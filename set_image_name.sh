#!/bin/bash

IMGNAME=$1

echo '# `date -R`' >vars.sh
echo -e "export IMGNAME=${IMGNAME}" >>vars.sh