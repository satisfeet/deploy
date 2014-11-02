#!/bin/bash

set -u
set -e

DIR=$(mktemp -d)

NAME=nginx

GIT_WORK_TREE=$DIR git checkout -f

docker build \
	--tag $NAME $DIR

docker stop $NAME || true
docker rm $NAME || true

docker run \
	--name $NAME
	--publish 80:80 \
	--publish 443:443 \
    --link jacana:jacana \
	--link quetzal:quetzal \
	--detach $NAME
