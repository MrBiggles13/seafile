#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/compose"

if [[ ! -f .env ]]; then
  echo "ERROR: .env not found. Run: cp env.example .env && edit it"
  exit 1
fi

# ---------- Host preparation (bind mounts) ----------
echo "[1/6] Preparing host directories under /opt ..."

sudo mkdir -p \
  /opt/seafile-data \
  /opt/seafile-mysql \
  /opt/seafile-es \
  /opt/seafile-redis \
  /opt/clamav-db \
  /opt/prometheus-data \
  /opt/grafana-data \
  /opt/alertmanager-data \
  /opt/seafile-nginx \
  /opt/seafile-cloudflared \
  /opt/seafile-monitoring/{prometheus,grafana/provisioning,grafana/dashboards,blackbox,alertmanager}

# Reasonable defaults for lab + most prod installs.
# Tighten later if you want strict UID/GID ownership.
sudo chmod 755 /opt/seafile-data /opt/seafile-mysql /opt/seafile-redis \
  /opt/clamav-db /opt/prometheus-data /opt/grafana-data /opt/alertmanager-data \
  /opt/seafile-nginx /opt/seafile-cloudflared /opt/seafile-monitoring

sudo chmod 777 -R /opt/seafile-es

# ---------- Copy config from repo to host paths ----------
echo "[2/6] Syncing config files to /opt ..."

sudo rsync -a --delete ./config/nginx/          /opt/seafile-nginx/
sudo rsync -a --delete ./config/cloudflared/    /opt/seafile-cloudflared/
sudo rsync -a --delete ./monitoring/prometheus/ /opt/seafile-monitoring/prometheus/
sudo rsync -a --delete ./monitoring/grafana/    /opt/seafile-monitoring/grafana/
sudo rsync -a --delete ./monitoring/blackbox/   /opt/seafile-monitoring/blackbox/
sudo rsync -a --delete ./monitoring/alertmanager/ /opt/seafile-monitoring/alertmanager/

echo "[3/6] Building custom Seafile image (clamdscan wrapper)..."
docker build -t "$(grep -E '^SEAFILE_IMAGE=' .env | cut -d= -f2-)" ../image

echo "[4/6] Starting stack..."
docker compose up -d

echo "[5/6] Waiting briefly..."
sleep 5

echo "[6/6] Running healthcheck..."
bash ../scripts/healthcheck.sh

echo "Install complete."
