#!/bin/bash

source vars.sh

docker build -t ${IMGNAME}:latest --build-arg user_home=$HOME -f Dockerfile .
