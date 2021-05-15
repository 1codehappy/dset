#!/usr/bin/env bash
# Create .env file from example file.
set -e

DSET_ROOT=$(pwd)

SOURCE_ENV_FILE=${DSET_ROOT}/.env.example
TARGET_ENV_FILE=${DSET_ROOT}/.env

# set defaults.
if [[ -f ${SOURCE_ENV_FILE} && ! -f ${TARGET_ENV_FILE} ]]; then
    cp ${SOURCE_ENV_FILE} ${TARGET_ENV_FILE}
fi
