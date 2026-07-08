#!/usr/bin/env bash

set -euo pipefail

databaseName="${1:-}"

: "${databaseName:?Error: database name cannot be empty.
Usage: bash 01_create_database_db.sh <database_name>}"

# <-- Start SQL code -->

psql -v ON_ERROR_STOP=1 -d postgres <<SQL

CREATE DATABASE $databaseName;

SQL

# <-- End SQL code -->
