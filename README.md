# Database Engineering and Query Optimization

PostgreSQL coursework and practical exercises covering relational queries, business analytics and query-performance analysis.

## Setup

Ubuntu or WSL with `sudo`. `bash setup.sh` installs PostgreSQL (`postgresql`, `postgresql-client`), starts the server, loads Chinook from `chinook/Chinook_PostgreSql.sql` (the script drops and recreates a database named `chinook`, so it overwrites an existing one with that name) and runs `Group01_query.sql`.

```bash
bash setup.sh
sudo -u postgres psql -d chinook -f Group01_query.sql    # re-run the queries later
```

The data is the bundled Chinook PostgreSQL script (no download). Tested against PostgreSQL 16 (the Ubuntu 24.04 version).

## Chinook database analysis

The root-level SQL exercise uses the Chinook music-store database to answer business questions with joins, subqueries, grouping and aggregation.

The ten questions cover:
- Employee reporting relationships
- Customer purchasing activity
- Average invoice totals by country
- Revenue and track counts by genre
- Playlist usage and purchase frequency
- Customer coverage across genres

### Run the SQL exercise

Requires PostgreSQL and the Chinook database dump.

```bash
# Load the Chinook database (adjust the path and role for your setup).
psql -U postgres -f chinook/Chinook_PostgreSql.sql

# Execute the query set.
psql -U postgres -d chinook -f Group01_query.sql
```

- [SQL queries](Group01_query.sql)
- [Original query version](Group01_query_original.sql)
- [Reference output](Group01_output.txt)
- [Assignment report](Group01_report.pdf)

## Query optimization and performance analysis

The [Query-Optimization-and-Performance-Analysis](Query-Optimization-and-Performance-Analysis/) directory contains the separate query-optimization work. Consult its own README and experiment files for workload setup, measurements and conclusions.

## Scope

This repository contains coursework and experimental analysis. Benchmark results should be interpreted in the context of the database, data scale, indexes, PostgreSQL configuration and hardware used.
