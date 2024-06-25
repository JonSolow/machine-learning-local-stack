#!/bin/sh

REPO_ROOT_DIR=`git rev-parse --show-toplevel`

# NOTE - run initialize_airbye.sh to setup airbyte repo locally

# SEE - https://docs.airbyte.com/deploying-airbyte/docker-compose#setup--launch-airbyte

# switch into Airbyte directory
cd airbyte

# start Airbyte
./run-ab-platform.sh