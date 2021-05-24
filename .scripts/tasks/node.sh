#!/usr/bin/env bash
# Create node image.
set -e

DSET_ROOT=$(pwd)

for options in "$@"
do
    key=$(echo $options | cut -f1 -d=)
    value=$(echo $options | cut -f2 -d=)

    case "$key" in
        "--image")          imageName=${value} ;;
        "--node-version")   nodeVersion=${value} ;;
        "--path")           path=${value} ;;
        "--group")          group=${value} ;;
        "--user")           user=${value} ;;
        "--bash")           bash=${value} ;;
        *)
    esac
done

docker build \
    -t ${imageName:-"dset/node"} \
    -f ${DSET_ROOT}/node/Dockerfile \
    --build-arg NODE_VERSION=${nodeVersion:-14.16} \
    --build-arg APP_PATH=${path:-"/var/www/app"} \
    --build-arg GROUPNAME=${group:-"dset"} \
    --build-arg PUID=$(id -u $(whoami)) \
    --build-arg PGID=$(id -g $(whoami)) \
    --build-arg IDENTIFIER=${bash:-"dset"} \
    --build-arg USERNAME=${user:-"$(whoami)"} \
    .
