#!/bin/bash

docker-compose -f docker-compose.yml -f docker-compose.local.yml --env-file .env.local up -d

