#!/bin/sh

REPO_ROOT_DIR=`git rev-parse --show-toplevel`


# SEE - https://docs.airbyte.com/deploying-airbyte/docker-compose#setup--launch-airbyte

# clone Airbyte from GitHub
git clone --depth=1 https://github.com/airbytehq/airbyte.git

