#!/bin/bash

source vars.sh

docker exec -it `docker ps |grep ${IMGNAME}:latest|cut -d ' ' -f 1`  zsh
