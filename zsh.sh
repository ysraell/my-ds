#!/bin/bash

docker exec -it `docker ps |grep my-ds:latest|cut -d ' ' -f 1`  zsh
