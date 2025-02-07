#!/usr/bin/env bash
set -e


while true
do
	if [ -e yes.do ]
    then
        echo "Shutdown! Yes!"
        echo "Wait 10 min..."
        sleep 10m
        rm -f yes.do
        poweroff
    else
        echo "No shutdown! No!"
    fi
	sleep 10
done

#EOF