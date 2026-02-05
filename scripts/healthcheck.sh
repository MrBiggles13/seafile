#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/compose"

pass(){ echo "OK   - $1"; }
fail(){ echo "FAIL - $1"; exit 1; }

# Core health
docker compose ps >/dev/null || fail "docker compose not running"

# DB
DB_ROOT_PASSWORD="$(grep -E '^DB_ROOT_PASSWORD=' .env | cut -d= -f2- || true)"
docker compose exec -T db mariadb -uroot -p"$DB_ROOT_PASSWORD" -e "SELECT 1;" >/dev/null \
  && pass "MariaDB reachable" || fail "MariaDB unreachable"

# Redis
docker compose exec -T redis redis-cli ping | grep -q PONG \
  && pass "Redis reachable" || fail "Redis unreachable"

# Elasticsearch
docker compose exec -T elasticsearch sh -lc 'curl -fsS http://localhost:9200 >/dev/null' \
  && pass "Elasticsearch reachable" || fail "Elasticsearch unreachable"

# ClamAV port
docker compose exec -T seafile sh -lc 'timeout 2 bash -c "</dev/tcp/clamav/3310" >/dev/null 2>&1' \
  && pass "ClamAV clamd reachable" || fail "ClamAV clamd not reachable"

# confirm Seafile can reach clamd over the docker network
docker compose exec -T seafile sh -lc 'python3 - <<PY
import socket, sys
s=socket.socket(); s.settimeout(2)
try:
    s.connect(("clamav",3310))
    sys.exit(0)
except Exception:
    sys.exit(1)
finally:
    try: s.close()
    except: pass
PY' \
  && pass "Seafile can reach ClamAV (tcp/3310)" || fail "Seafile cannot reach ClamAV (tcp/3310)"

# Nginx reachability (nginx-unprivileged listens on 8080)
docker compose exec -T nginx sh -lc 'nginx -t >/dev/null 2>&1' \
  && pass "Nginx config OK" || fail "Nginx config invalid"
docker compose exec -T seafile sh -lc 'wget -qO- http://127.0.0.1/ >/dev/null 2>&1' \
  && pass "Seafile web responding" || fail "Seafile web not responding"

# Prometheus ready
docker compose exec -T prometheus sh -lc 'wget -qO- http://127.0.0.1:9090/-/ready >/dev/null' \
  && pass "Prometheus ready" || fail "Prometheus not ready"

# Grafana running
docker compose exec -T grafana sh -lc 'wget -qO- http://127.0.0.1:3000/api/health >/dev/null' \
  && pass "Grafana reachable (internal)" || fail "Grafana not reachable"

# Alertmanager ready
docker compose exec -T alertmanager sh -lc 'wget -qO- http://127.0.0.1:9093/-/ready >/dev/null' \
  && pass "Alertmanager ready" || fail "Alertmanager not ready"

echo "Healthcheck completed."
