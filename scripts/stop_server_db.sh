#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
DATA_DIR="$SCRIPT_DIR/../../."

if pg_ctl -D "$DATA_DIR" status >/dev/null 2>&1; then
  # Stop postgreSQL server
  pg_ctl -D $DATA_DIR stop
else
  echo "PostgreSQL server is not working in the first place!"
fi
