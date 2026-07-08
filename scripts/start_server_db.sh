#!/usr/bin/env bash

set -euo pipefail


SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$SCRIPT_DIR/../../."
LOG_FILE="$SCRIPT_DIR/../logs/postgresql.log"

# create "logs/postgresql.log" file if not exists
mkdir -p "$(dirname "$LOG_FILE")"

if pg_ctl -D "$DATA_DIR" status >/dev/null 2>&1; then
  echo "PostgreSQL server is already running!"
else
  # Start server and save logs in "postgresql.log""
  pg_ctl -D "$DATA_DIR" -l "$LOG_FILE" start
fi
