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
PORT_STREAMLIT=`settings2env PORT_STREAMLIT`
PORT_FREE=`settings2env PORT_FREE`

docker run \
    -p ${PORT_JUPYTERLAB}:8888 \
    -p ${PORT_STREAMLIT}:8501 \
    -p ${PORT_FREE}:8000 \
    -v $HOME:/work \
    -d -t ${APP_NAME}:${TAG}

echo 'Wait 5 seconds for Jupyter Lab access...'
sleep 5
docker exec -it `docker ps |grep ${APP_NAME}:${TAG}|cut -d ' ' -f 1`  jupyter notebook list


#EOF
