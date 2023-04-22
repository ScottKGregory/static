#!/bin/bash

set -ex

CURRENT_DIR="${PWD##*/}"
TAG=$(git rev-parse --short HEAD)

REGISTRY="hub.docker.com"

docker build --platform linux/amd64 -t ${REGISTRY}/${CURRENT_DIR}:${TAG} .
docker tag ${REGISTRY}/${CURRENT_DIR}:${TAG} ${REGISTRY}/${CURRENT_DIR}:latest
docker push ${REGISTRY}/${CURRENT_DIR}
docker tag ${REGISTRY}/${CURRENT_DIR}:latest ${REGISTRY}/${CURRENT_DIR}:${TAG}
docker push ${REGISTRY}/${CURRENT_DIR}