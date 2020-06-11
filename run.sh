#!/bin/bash

#./stop_CONTAINER.sh || echo 'No container with iamge my-ds:latest running.'
docker run -d -p 8888:8888 -p 8501:8501 -v $HOME:/work -t my-ds:latest
echo 'Wait 5 seconds for Jupyter Lab access...'
sleep 5
docker exec -it `docker ps |grep my-ds:latest|cut -d ' ' -f 1`  jupyter notebook list
#echo -e '\nYou can now view your Streamlit app in your browser. \n\nLocal URL: http://localhost:8501\n'

