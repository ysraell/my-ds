#!/usr/bin/env bash
set -e

source ./scripts/yaml2env PORT_JUPYTERLAB settings.yml
source ./scripts/yaml2env CONTAINER_NAME settings.yml

TOKEN=`docker exec -it ${CONTAINER_NAME} /bin/bash -c " jupyter server list --json |/usr/bin/jq -r '.token' "` 
echo "http://localhost:${PORT_JUPYTERLAB}/?token=${TOKEN}"

#EOF
