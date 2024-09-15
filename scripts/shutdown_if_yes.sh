#!/usr/bin/env bash
set -e


while true
do
	if [ -e yes.do ]
    then
        echo "Shutdown! Yes!"
    else
        echo "No shutdown! No!"
    fi
	sleep 10
done

#EOF