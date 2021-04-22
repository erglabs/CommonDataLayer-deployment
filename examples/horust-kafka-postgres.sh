#!/usr/bin/env bash
set -euo pipefail

cd cdl

cargo build

cd ..

docker-compose -f compose/docker-compose.yml down --remove-orphans
docker-compose -f compose/docker-compose.yml up -d postgres kafka jaeger

sleep 15s

rm logs/*

HORUST_LOG=info horust \
    --services-path ./bare/horust/kafka/base \
    --services-path ./bare/horust/kafka/postgres
