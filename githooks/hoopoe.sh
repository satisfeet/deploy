#!/bin/bash

set -u
set -e

DIR=$(mktemp -d)

NAME=hoopoe

GIT_WORK_TREE=$DIR git checkout -f

docker build \
	--tag $NAME $DIR

docker stop $NAME || true
docker rm $NAME || true

docker run \
	--name $NAME \
	--link mongo:mongo \
	--detach $NAME
