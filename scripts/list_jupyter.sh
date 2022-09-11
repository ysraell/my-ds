#!/usr/bin/env bash
set -e

function settings2env() {
    echo `grep $1: settings.yml |cut -d ':' -f 2`
}

if [ -z $1 ] ;
then
    TAG=`settings2env version`
else
    TAG=$1
fi

APP_NAME=`settings2env APP_NAME`
PORT_JUPYTERLAB=`settings2env PORT_JUPYTERLAB`
CONTAINER_NAME=`settings2env CONTAINER_NAME`
TOKEN=`docker exec -it ${CONTAINER_NAME} /bin/bash -c " jupyter server list --json |/usr/bin/jq -r '.token' "` 
echo "http://localhost:${PORT_JUPYTERLAB}/?token=${TOKEN}"

#EOF
