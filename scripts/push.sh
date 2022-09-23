#!/usr/bin/env bash
set -e

CI_COMMIT_TAG=$2
EXT_SETTINGS=$1

source ./scripts/yaml2env version settings.yml

if [ -z $2 ] ;
then
    CI_COMMIT_TAG=${version}
else
    CI_COMMIT_TAG=$2
fi

if [ -z $3 ] ;
then
    TAG=${version}
else
    TAG=$3
fi

source ./scripts/yaml2env APP_NAME settings.yml
source ./scripts/yaml2env CI_REGISTRY ${EXT_SETTINGS}

docker tag $APP_NAME:$TAG  $CI_REGISTRY/$APP_NAME:$CI_COMMIT_TAG

source ./scripts/yaml2env CI_REGISTRY_USER ${EXT_SETTINGS}
source ./scripts/yaml2env CI_REGISTRY_PASSWORD ${EXT_SETTINGS}

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
