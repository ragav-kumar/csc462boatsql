#!/bin/bash

# docker info
# docker ps

####################
## node

# docker node ls

## Remove nodes
# docker node rm NODE_ID
# docker node rm `docker node ls -q`

####################
## stack

# docker stack ls
# docker stack services boatapp
# docker stack ps boatapp
# docker stack ps --format "{{.Name}} {{.Node}} {{.Error}}" --no-trunc boatapp

## Remove stack
# docker stack rm boatapp

####################
## services

# docker service ls
# docker service ps boatapp_web

# docker service inspect --pretty boatapp_web
# docker service logs -f boatapp_web

## Scale up a service
# docker service scale boatapp_web=2

## Remove service
# docker service rm boatapp_web
# docker service rm `docker service ls -q`

####################
## container

# docker container ls

## Container shell access
# docker exec -it boatapp_web bash 

## Check if container have access to others via hostname
# docker exec boatapp_web getent hosts boatapp_web

