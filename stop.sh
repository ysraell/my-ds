#!/bin/bash

source vars.sh

docker stop `docker ps |grep ${IMGNAME}:latest|cut -d ' ' -f 1`
