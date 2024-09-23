#!/bin/bash

dbclient-fetcher psql
dropdb $METABASE_POSTGRESQL_URL
createdb $METABASE_POSTGRESQL_URL
pg_dump --clean --if-exists --format c --dbname $SCALINGO_POSTGRESQL_URL --no-owner --no-privileges --no-comments --exclude-schema 'information_schema' --exclude-schema '^pg_*' --exclude-table="ahoy_events" --exclude-table="ahoy_visits" --exclude-table="versions" --file dump.pgsql
pg_restore --clean --if-exists --no-owner --no-privileges --no-comments --dbname $METABASE_POSTGRESQL_URL dump.pgsql