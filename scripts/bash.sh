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

docker exec -it `docker ps |grep ${APP_NAME}:${TAG}|cut -d ' ' -f 1`  bash

#EOF
