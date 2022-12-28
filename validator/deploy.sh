#!/bin/bash
docker-compose -f docker/docker-compose.yml stop
docker-compose -f docker/docker-compose.yml --env-file docker/.env up -d --build --force-recreate