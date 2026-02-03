#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/compose"

OUT="${1:-$ROOT/../diag/diag_$(date +%F_%H%M%S)}"
mkdir -p "$OUT"

docker compose ps > "$OUT/ps.txt" || true
docker compose logs --no-color --tail=500 > "$OUT/logs_tail500.txt" || true

echo "Written: $OUT"
