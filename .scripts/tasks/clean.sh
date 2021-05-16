#!/usr/bin/env bash
# Remove <none> docker images (after building).
set -e

docker rmi $(docker images -f "dangling=true" -q) -f