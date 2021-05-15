#!/usr/bin/env bash

# determine dset root.
CURRENT_ROOT="$(dirname $0)"

# run original command.
./${CURRENT_ROOT}/bin/docker-set "$@"
