#!/usr/bin/env bash

if [ -f /run/nginx/nginx.pid ]; then
  nohup /usr/local/sbin/php-fpm -y \
    /usr/local/etc/php-fpm.conf -F -O > /dev/null 2>&1 \
  && nginx -g "daemon off;";
else
  /bin/bash;
fi
