#!/bin/bash


POSTGRES_MOUNT=/mnt/hd2/postgres_mount

mkdir -p $POSTGRES_MOUNT

docker run -d \
	--name db-postgres \
	-e POSTGRES_PASSWORD=mysecretpassword \
	-e PGDATA=/var/lib/postgresql/data/pgdata \
	-v $POSTGRES_MOUNT:/var/lib/postgresql/data \
    -p 5432:5432 \
	postgres

#EOF