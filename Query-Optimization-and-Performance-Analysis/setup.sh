#!/usr/bin/env bash
# Setup for Ubuntu/WSL: PostgreSQL 17 (+ pg_hint_plan), Python venv, TPC-H database.
# Run:  PGPASSWORD=<choose a password> bash setup.sh [scale-factor]   (default 0.1; assignments used 10)
set -euo pipefail
cd "$(dirname "${BASH_SOURCE[0]}")"
SCALE="${1:-0.1}"
: "${PGPASSWORD:?export PGPASSWORD=<password for the local postgres user> first}"

sudo apt-get update
sudo apt-get install -y python3 python3-venv python3-pip build-essential postgresql-common curl ca-certificates
# README requires PostgreSQL 17; add the official PGDG apt repo (script ships with postgresql-common).
sudo /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh -y
sudo apt-get install -y postgresql-17 postgresql-client-17 postgresql-server-dev-17

# Start the server (WSL usually has no systemd: fall back to the service wrapper).
sudo service postgresql start || sudo systemctl start postgresql
# Password for the default 'postgres' user, used by setup_tpch.py over TCP (localhost:5432).
sudo -u postgres psql -c "ALTER USER postgres PASSWORD '${PGPASSWORD}';"

# pg_hint_plan is needed only by Assignment2/task4 (vendored copy in the repo).
if [ -d Assignment2/pg_hint_plan-REL17_1_7_1 ]; then
  (cd Assignment2/pg_hint_plan-REL17_1_7_1 && make && sudo make install)
  echo "NOTE: Assignment2/task4 also needs shared_preload_libraries = 'pg_hint_plan' in postgresql.conf, then a restart."
fi

python3 -m venv .venv
.venv/bin/pip install --upgrade pip
.venv/bin/pip install -r requirements.txt -r requirements-data.txt

# Create and load tpch_db with DuckDB's TPC-H generator (see README / setup_tpch.py).
.venv/bin/python setup_tpch.py --scale "$SCALE"
echo "Done. Activate with: source .venv/bin/activate"
