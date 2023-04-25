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
source ./scripts/yaml2env DOCKER_ACCOUNT settings.yml

docker tag $APP_NAME:$TAG  $DOCKER_ACCOUNT/$APP_NAME:$CI_COMMIT_TAG

#source ./scripts/yaml2env DOCKER_REGISTRY_USER ${EXT_SETTINGS}
#source ./scripts/yaml2env DOCKER_REGISTRY_PASSWORD ${EXT_SETTINGS}
#docker login -u "$DOCKER_REGISTRY_USER" -p "$DOCKER_REGISTRY_PASSWORD"

docker push $DOCKER_ACCOUNT/$APP_NAME:$CI_COMMIT_TAG

source ./scripts/yaml2env PORT_JUPYTERLAB settings.yml
source ./scripts/yaml2env PORT_STREAMLIT settings.yml
source ./scripts/yaml2env PORT_FREE settings.yml
cat base_docker-compose.yml \
    |sed -e "s/PORT_JUPYTERLAB/${PORT_JUPYTERLAB}/g" \
    |sed -e "s/PORT_STREAMLIT/${PORT_STREAMLIT}/g" \
    |sed -e "s/PORT_FREE/${PORT_FREE}/g" \
    |sed -e "s/DOCKER_ACCOUNT/${DOCKER_ACCOUNT}/g" \
    |sed -e "s/APP_NAME/${APP_NAME}/g" \
    |sed -e "s/CI_COMMIT_TAG/${CI_COMMIT_TAG}/g" > docker-compose.yml

docker-compose -f docker-compose.yml config > docker-stack.yml

#EOF
