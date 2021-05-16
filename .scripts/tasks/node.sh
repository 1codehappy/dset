#!/usr/bin/env bash
# Create node image.
set -e

DSET_ROOT=$(pwd)

docker build \
    -t ${DSET_NODE_IMAGE:-"dset/node"} \
    -f ${DSET_ROOT}/node/Dockerfile \
    --build-arg NODE_VERSION=${NODE_VERSION} \
    --build-arg APP_PATH=${DSET_NODE_PATH:-"/var/www/app"} \
    --build-arg PUID=$(id -u $(whoami)) \
    --build-arg PGID=$(id -g $(whoami)) \
    .
