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
BASE_IMAGE_NAME=`settings2env BASE_IMAGE_NAME`
BASE_IMAGE_TAG=`settings2env BASE_IMAGE_TAG`

docker build -t $APP_NAME:$TAG --build-arg TAG=$BASE_IMAGE_TAG --build-arg BASE_IMAGE_NAME=$BASE_IMAGE_NAME --file Dockerfile .
