#!/usr/bin/env bash
set -euo pipefail

cd cdl

cargo build

cd ..

if [[ $* == *--reload* ]]
then
    docker-compose -f compose/docker-compose.yml down --remove-orphans
    rm -Rf /tmp/schema-service/db
fi
docker-compose -f compose/docker-compose.yml up -d postgres kafka jaeger

sleep 15s

rm logs/*.log

HORUST_LOG=info horust \
    --services-path ./bare/horust/kafka/base \
    --services-path ./bare/horust/kafka/postgres
