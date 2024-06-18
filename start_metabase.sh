#!/bin/sh


REPO_ROOT_DIR=`git rev-parse --show-toplevel`
METABASE_LOCAL_DATA_DIR="${REPO_ROOT_DIR}/data/metabase-data/"
DUCKDB_FILE_PATH="${REPO_ROOT_DIR}/dagster-dbt/dbt_project/dev.duckdb"

METABASE_PORT=6382

docker build . -f metabase/Dockerfile --tag metaduck:latest

docker run --rm -it -d \
  -p $METABASE_PORT:3000 \
  -v $METABASE_LOCAL_DATA_DIR:/metabase-data \
  -v $DUCKDB_FILE_PATH:/database/dev.duckdb \
  -e "MB_DB_FILE=/metabase-data/metabase.db" \
  -e "MB_PLUGINS_DIR=/home/plugins" \
  --name metabase metaduck