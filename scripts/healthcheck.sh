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
docker compose exec -T db mariadb -uroot -p"$DB_ROOT_PASSWORD" -e "SELECT 1;" >/dev/null   && pass "MariaDB reachable" || fail "MariaDB unreachable"

# Redis
docker compose exec -T redis redis-cli ping | grep -q PONG   && pass "Redis reachable" || fail "Redis unreachable"

# ES
docker compose exec -T elasticsearch sh -lc 'curl -s http://localhost:9200 >/dev/null'   && pass "Elasticsearch reachable" || fail "Elasticsearch unreachable"

# ClamAV port
docker compose exec -T seafile sh -lc 'timeout 2 bash -c "</dev/tcp/clamav/3310" >/dev/null 2>&1'   && pass "ClamAV clamd reachable" || fail "ClamAV clamd not reachable"

# Nginx reachability
docker compose exec -T nginx sh -lc 'wget -qO- http://localhost:8080/ >/dev/null'   && pass "Nginx can reach Seafile" || fail "Nginx cannot reach Seafile"

# Prometheus scrape itself
docker compose exec -T prometheus sh -lc 'wget -qO- http://localhost:9090/-/ready >/dev/null'   && pass "Prometheus ready" || fail "Prometheus not ready"

# Grafana running
docker compose exec -T grafana sh -lc 'wget -qO- http://localhost:3000/api/health >/dev/null'   && pass "Grafana reachable (internal)" || fail "Grafana not reachable"



# Alertmanager running
docker compose exec -T alertmanager sh -lc 'wget -qO- http://localhost:9093/-/ready >/dev/null'   && pass "Alertmanager ready" || fail "Alertmanager not ready"

echo "Healthcheck completed."
