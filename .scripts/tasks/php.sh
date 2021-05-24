#!/usr/bin/env bash
# Create nginx & php-fpm image.
set -e

DSET_ROOT=$(pwd)


for options in "$@"
do
    key=$(echo $options | cut -f1 -d=)
    value=$(echo $options | cut -f2 -d=)

    case "$key" in
        "--image")                  imageName=${value} ;;
        "--php-version")            phpVersion=${value} ;;
        "--php-mode")               phpMode=${value} ;; # cli or fpm
        "--path")                   path=${value} ;;
        "--group")                  group=${value} ;;
        "--user")                   user=${value} ;;
        "--bash")                   bash=${value} ;;
        "--xdebug")                 xdebug=${value} ;;
        "--upload-max-filesize")    uploadMaxFileSize=${value} ;;
        "--memory-limit")           phpMemoryLimit=${value} ;;
        "--opcache")                opcache=${value} ;;
        "--nginx-listen-port")      nginxPort=${value} ;;
        "--nginx-vhost-path")       nginxPath=${value} ;;
        *)
    esac
done

docker build \
    -t ${imageName:-"dset/php"} \
    -f ${DSET_ROOT}/php/Dockerfile \
    --build-arg PHP_VERSION=${phpVersion:-8.0} \
    --build-arg PHP_MODE=${phpVersion:-fpm} \
    --build-arg APP_PATH=${path:-"/var/www/app"} \
    --build-arg GROUPNAME=${group:-"dset"} \
    --build-arg PUID=$(id -u $(whoami)) \
    --build-arg PGID=$(id -g $(whoami)) \
    --build-arg IDENTIFIER=${bash:-"dset"} \
    --build-arg USERNAME=${user:-"$(whoami)"} \
    --build-arg PHP_XDEBUG_ENABLE=${xdebug:-0} \
    --build-arg PHP_UPLOAD_MAX_FILESIZE=${uploadMaxFileSize:-2M} \
    --build-arg PHP_MEMORY_LIMIT=${phpMemoryLimit:256M} \
    --build-arg PHP_OPCACHE_ENABLE=${opcache:-0} \
    --build-arg NGINX_ROOT=${nginxPort:-8080} \
    --build-arg NGINX_ROOT=${nginxPath:-"/var/www/app"} \
    .
