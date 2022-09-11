#!/usr/bin/env bash
set -e

function settings2env() {
    echo `grep $1: settings.yml |cut -d ':' -f 2`
}


CONTAINER_NAME=`settings2env CONTAINER_NAME`

docker rm ${CONTAINER_NAME}

#EOF
