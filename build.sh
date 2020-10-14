#!/bin/bash

docker build -t my-ds:latest --build-arg user_home=$HOME -f Dockerfile .
