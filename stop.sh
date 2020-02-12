#!/bin/bash

docker stop `docker ps |grep my-ds:latest|cut -d ' ' -f 1`
