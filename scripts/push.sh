#!/usr/bin/env bash
set -e

CI_COMMIT_TAG=$2
EXT_SETTINGS=$1

function settings2env() {
    echo `grep $1: $2 |cut -d ':' -f 2 |xargs`
}

if [ -z $2 ] ;
then
    CI_COMMIT_TAG=`settings2env version settings.yml`
else
    CI_COMMIT_TAG=$2
fi

if [ -z $3 ] ;
then
    TAG=`settings2env version settings.yml`
else
    TAG=$3
fi

APP_NAME=`settings2env APP_NAME settings.yml`
CI_REGISTRY=`settings2env CI_REGISTRY ${EXT_SETTINGS}`

docker tag $APP_NAME:$TAG  $CI_REGISTRY/$APP_NAME:$CI_COMMIT_TAG

CI_REGISTRY_USER=`settings2env CI_REGISTRY_USER ${EXT_SETTINGS}`
CI_REGISTRY_PASSWORD=`settings2env CI_REGISTRY_PASSWORD ${EXT_SETTINGS}`

#docker login -u "$CI_REGISTRY_USER" -p "$CI_REGISTRY_PASSWORD"

docker push $CI_REGISTRY/$APP_NAME:$CI_COMMIT_TAG

PORT_JUPYTERLAB=`settings2env PORT_JUPYTERLAB settings.yml`
PORT_STREAMLIT=`settings2env PORT_STREAMLIT settings.yml`
PORT_FREE=`settings2env PORT_FREE settings.yml`
cat base_docker-compose.yml \
    |sed -e "s/PORT_JUPYTERLAB/${PORT_JUPYTERLAB}/g" \
    |sed -e "s/PORT_STREAMLIT/${PORT_STREAMLIT}/g" \
    |sed -e "s/PORT_FREE/${PORT_FREE}/g" \
    |sed -e "s/CI_REGISTRY/${CI_REGISTRY}/g" \
    |sed -e "s/APP_NAME/${APP_NAME}/g" \
    |sed -e "s/CI_COMMIT_TAG/${CI_COMMIT_TAG}/g" > docker-compose.yml


docker-compose -f docker-compose.yml config > docker-stack.yml

#EOF
