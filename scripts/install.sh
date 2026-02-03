#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/compose"

if [[ ! -f .env ]]; then
  echo "ERROR: .env not found. Run: cp env.example .env && edit it"
  exit 1
fi

echo "[1/4] Start stack (hardened + monitoring)..."
docker compose up -d

echo "[2/4] Wait briefly..."
sleep 5

echo "[3/4] Healthcheck..."
bash ../scripts/healthcheck.sh

echo "[4/4] Done."
echo "Grafana is internal by default. To publish it, add an additional hostname in Cloudflare and cloudflared ingress."
