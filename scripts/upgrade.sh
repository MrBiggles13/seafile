#!/usr/bin/env bash
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/compose"

echo "Recommended cadence: quarterly appliance upgrade + monthly security patches."
echo "This script performs: backup (optional) -> pull -> rebuild (if needed) -> restart -> healthcheck"

docker compose pull || true
docker compose up -d
bash ../scripts/healthcheck.sh
