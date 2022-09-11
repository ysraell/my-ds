#!/usr/bin/env bash
set -e

function settings2env() {
    echo `grep $1: settings.yml |cut -d ':' -f 2`
}

# if [ -z $1 ] ;
# then
#     TAG=`settings2env version`
# else
#     TAG=$1
# fi

CONTAINER_NAME=`settings2env CONTAINER_NAME`

docker exec -it ${CONTAINER_NAME} zsh

#EOF
