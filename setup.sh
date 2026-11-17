#!/usr/bin/env bash
# Setup for Ubuntu/WSL: PostgreSQL, load Chinook (chinook/Chinook_PostgreSql.sql creates and fills DB 'chinook'), run the queries.
set -euo pipefail
cd "$(dirname "$0")"
sudo apt-get update
sudo apt-get install -y postgresql postgresql-client
sudo service postgresql start
# Feed files on stdin so the postgres OS user does not need read access to this folder.
sudo -u postgres psql -v ON_ERROR_STOP=1 -q < chinook/Chinook_PostgreSql.sql
sudo -u postgres psql -d chinook -v ON_ERROR_STOP=1 < Group01_query.sql | tail -n 15
echo "Done. Re-run the queries any time: sudo -u postgres psql -d chinook -f Group01_query.sql"
