#!/usr/bin/env bash
set -e


source ./scripts/yaml2env APP_NAME settings.yml
source ./scripts/yaml2env BASE_IMAGE_NAME settings.yml
source ./scripts/yaml2env BASE_IMAGE_TAG settings.yml
source ./scripts/yaml2env version settings.yml
TAG=$version

docker build -t $APP_NAME:$TAG --build-arg TAG=$BASE_IMAGE_TAG --build-arg BASE_IMAGE_NAME=$BASE_IMAGE_NAME --file Dockerfile .
