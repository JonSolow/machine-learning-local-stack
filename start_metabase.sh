#!/bin/sh


REPO_ROOT_DIR=`git rev-parse --show-toplevel`
METABASE_LOCAL_DATA_DIR="${REPO_ROOT_DIR}/data/metabase-data"

METABASE_PORT=6382

docker run --rm -d \
  -p $METABASE_PORT:3000 \
  -v $METABASE_LOCAL_DATA_DIR:/metabase-data \
  -e "MB_DB_FILE=/metabase-data/metabase.db" \
  --name metabase metabase/metabase