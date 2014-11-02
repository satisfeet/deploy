SHELL := /bin/bash

install: setup clone build start
	echo "Push to repositories"

setup:
	@chmod +x githooks/*.sh

clone:
	@git init --bare ~/nginx.git
	@git init --bare ~/hoopoe.git
	@git init --bare ~/jacana.git
	@git init --bare ~/quetzal.git
	@cp githooks/nginx.sh ~/nginx.git/hooks/post-receive
	@cp githooks/hoopoe.sh ~/hoopoe.git/hooks/post-receive
	@cp githooks/jacana.sh ~/jacana.git/hooks/post-receive
	@cp githooks/quetzal.sh ~/quetzal.git/hooks/post-receive

build:
	@docker pull debian
	@docker pull redis:latest
	@docker pull mongo:latest
	@docker pull node:0.11
	@docker pull golang:1.3.1
	@docker pull nginx:latest

start:
	@docker run \
		--name data \
		--volume /data \
		debian true
	@docker run \
		--name redis \
		--detach redis
	@docker run \
		--name mongo \
		--volumes-from data \
		--detach mongo

clean:
	@docker rm -f $(shell docker ps -a -q)

reset:
	@docker rmi $(shell docker images -q)

.PHONY: reinstall
