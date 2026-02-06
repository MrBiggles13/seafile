#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT/compose"

OUT="${1:-$ROOT/../backups/$(date +%F_%H%M%S)}"
mkdir -p "$OUT"

echo "Dumping DB..."
DB_ROOT_PASSWORD="$(grep -E '^DB_ROOT_PASSWORD=' .env | cut -d= -f2-)"
docker compose exec -T db sh -lc 'mariadb-dump -uroot -p"$MYSQL_ROOT_PASSWORD" --single-transaction seafile_db'   > "$OUT/seafile.sql"

echo "Saving config..."
tar -czf "$OUT/config.tgz" config monitoring .env docker-compose.yml

echo "Done: $OUT"
