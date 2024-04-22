#!/bin/sh

REPO_ROOT_DIR=`git rev-parse --show-toplevel`
cd $REPO_ROOT_DIR/dagster-dbt/dagster_project

DAGSTER_DBT_PARSE_PROJECT_ON_LOAD=1 \
DAGSTER_HOME=$REPO_ROOT_DIR/data \
pipenv run dagster dev