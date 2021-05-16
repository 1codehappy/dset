#!/usr/bin/env bash
# Create php cli image.
set -e

DSET_ROOT=$(pwd)

docker build \
    -t ${DSET_WORKER_IMAGE:-"dset/worker"} \
    -f ${DSET_ROOT}/php/Dockerfile \
    --build-arg PHP_VERSION=${PHP_VERSION} \
    --build-arg PHP_MODE=cli \
    --build-arg PUID=$(id -u $(whoami)) \
    --build-arg PGID=$(id -g $(whoami)) \
    --build-arg APP_PATH=${DSET_WORKER_PATH:-"/var/www/app"} \
    --build-arg PHP_XDEBUG_ENABLE=${PHP_XDEBUG_ENABLE} \
    --build-arg PHP_UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE} \
    --build-arg PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT} \
    --build-arg PHP_OPCACHE_ENABLE=${PHP_OPCACHE_ENABLE} \
    --build-arg PHP_OPCACHE_MEMORY_CONSUMPTION=${PHP_OPCACHE_MEMORY_CONSUMPTION} \
    --build-arg PHP_OPCACHE_INTERNED_STRINGS_BUFFER=${PHP_OPCACHE_INTERNED_STRINGS_BUFFER} \
    --build-arg PHP_OPCACHE_MAX_ACCELERATED_FILES=${PHP_OPCACHE_MAX_ACCELERATED_FILES} \
    --build-arg PHP_OPCACHE_REVALIDATE_FREQUENCY=${PHP_OPCACHE_REVALIDATE_FREQUENCY} \
    --build-arg PHP_OPCACHE_VALIDATE_TIMESTAMPS=${PHP_OPCACHE_VALIDATE_TIMESTAMPS} \
    --build-arg PHP_OPCACHE_VALIDATE_TIMESTAMPS=${PHP_OPCACHE_VALIDATE_TIMESTAMPS} \
    --build-arg PHP_OPCACHE_FAST_SHUT_DOWN=${PHP_OPCACHE_FAST_SHUT_DOWN} \
    .
