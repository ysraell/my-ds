#!/usr/bin/env bash
set -e

source ./scripts/yaml2env version settings.yml

if [ -z $1 ] ;
then
    TAG=${version}
else
    TAG=$1
fi

source ./scripts/yaml2env CONTAINER_NAME settings.yml
source ./scripts/yaml2env APP_NAME settings.yml
source ./scripts/yaml2env PORT_JUPYTERLAB settings.yml
source ./scripts/yaml2env PORT_STREAMLIT settings.yml
source ./scripts/yaml2env PORT_FREE settings.yml
source ./scripts/yaml2env SHM_SIZE settings.yml

docker run \
    -p ${PORT_JUPYTERLAB}:8888 \
    -p ${PORT_STREAMLIT}:8501 \
    -p ${PORT_FREE}:8000 \
    -v $HOME:/work \
    --shm-size=${SHM_SIZE} \
    --name ${CONTAINER_NAME} \
    -d -t ${APP_NAME}:${TAG}

echo 'Wait 5 seconds for Jupyter Lab access...'
sleep 5
CONTAINER=`docker ps |grep ${APP_NAME}:${TAG}|cut -d ' ' -f 1`
TOKEN=`docker exec -it ${CONTAINER} /bin/bash -c " jupyter server list --json |/usr/bin/jq -r '.token' " ` 
echo "http://localhost:${PORT_JUPYTERLAB}/?token=${TOKEN}"

#EOF
