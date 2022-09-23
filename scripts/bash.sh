#!/usr/bin/env bash
set -e

source ./scripts/yaml2env CONTAINER_NAME settings.yml

docker exec -it ${CONTAINER_NAME} bash

#EOF
