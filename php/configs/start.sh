#!/bin/bash

nohup /usr/local/sbin/php-fpm -y /usr/local/etc/php-fpm.conf -F -O > /dev/null 2>&1 &

nginx -g "daemon off;"
