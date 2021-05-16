#
# VERSIONS
#
# ARG NODE_VERSION=14.16
ARG PHP_VERSION=8.0
ARG PHP_MODE=fpm
# PHP_MODE can be `cli` or `fpm`

#
# PHP Official Image
#
FROM php:${PHP_VERSION}-${PHP_MODE}-alpine

#
# Author
#
LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

#
# Default values
#
ARG APP_ENV=production
ARG PUID=1000
ARG PGID=1000
ARG USERNAME=you
ARG APP_PATH=/var/www/app
ARG TIMEZONE=UTC

#
# Custom
#
ARG PHP_XDEBUG_ENABLE
ARG PHP_UPLOAD_MAX_FILESIZE
ARG PHP_MEMORY_LIMIT
ARG PHP_OPCACHE_ENABLE
ARG PHP_OPCACHE_MEMORY_CONSUMPTION
ARG PHP_OPCACHE_INTERNED_STRINGS_BUFFER
ARG PHP_OPCACHE_MAX_ACCELERATED_FILES
ARG PHP_OPCACHE_REVALIDATE_FREQUENCY
ARG PHP_OPCACHE_VALIDATE_TIMESTAMPS
ARG PHP_OPCACHE_FAST_SHUT_DOWN
ARG PHP_FPM_PM
ARG PHP_FPM_MAX_CHILDREN
ARG PHP_FPM_PROCESS_IDLE_TIMEOUT
ARG PHP_FPM_START_SERVERS
ARG PHP_FPM_MIN_SPARE_SERVERS
ARG PHP_FPM_MAX_SPARE_SERVERS
ARG PHP_FPM_MAX_REQUESTS
ARG NGINX_LISTEN_PORT
ARG NGINX_ROOT

#
# Environment variables
#
ENV APP_PATH=${APP_PATH} \
    PGID=${PGID} \
    PUID=${PUID} \
    PHP_INI_DIR=/usr/local/etc/php \
    PHP_CONF_DIR=/usr/local/etc/php/conf.d \
    PHP_FPM_POOL_DIR=/usr/local/etc/php-fpm.d \
    PS1="\u@dset:\w\\$ " \
    USERNAME=${USERNAME} \
# Custom
    PHP_XDEBUG_ENABLE=${PHP_XDEBUG_ENABLE} \
    PHP_UPLOAD_MAX_FILESIZE=${PHP_UPLOAD_MAX_FILESIZE} \
    PHP_MEMORY_LIMIT=${PHP_MEMORY_LIMIT} \
    PHP_OPCACHE_ENABLE=${PHP_OPCACHE_ENABLE} \
    PHP_OPCACHE_MEMORY_CONSUMPTION=${PHP_OPCACHE_MEMORY_CONSUMPTION} \
    PHP_OPCACHE_INTERNED_STRINGS_BUFFER=${PHP_OPCACHE_INTERNED_STRINGS_BUFFER} \
    PHP_OPCACHE_MAX_ACCELERATED_FILES=${PHP_OPCACHE_MAX_ACCELERATED_FILES} \
    PHP_OPCACHE_REVALIDATE_FREQUENCY=${PHP_OPCACHE_REVALIDATE_FREQUENCY} \
    PHP_OPCACHE_VALIDATE_TIMESTAMPS=${PHP_OPCACHE_VALIDATE_TIMESTAMPS} \
    PHP_OPCACHE_FAST_SHUT_DOWN=${PHP_OPCACHE_FAST_SHUT_DOWN} \
    PHP_FPM_PM=${PHP_FPM_PM} \
    PHP_FPM_MAX_CHILDREN=${PHP_FPM_MAX_CHILDREN} \
    PHP_FPM_PROCESS_IDLE_TIMEOUT=${PHP_FPM_PROCESS_IDLE_TIMEOUT} \
    PHP_FPM_START_SERVERS=${PHP_FPM_START_SERVERS} \
    PHP_FPM_MIN_SPARE_SERVERS=${PHP_FPM_MIN_SPARE_SERVERS} \
    PHP_FPM_MAX_SPARE_SERVERS=${PHP_FPM_MAX_SPARE_SERVERS} \
    PHP_FPM_MAX_REQUESTS=${PHP_FPM_MAX_REQUESTS} \
    NGINX_LISTEN_PORT=${NGINX_LISTEN_PORT} \
    NGINX_ROOT=${NGINX_ROOT}

#
# Work dir
#
WORKDIR ${APP_PATH}

#
# Settings
#
RUN set -ex \
#
# Install Packages
#
    && apk --no-cache add \
        bash \
        curl \
        freetype \
        git \
        gettext \
        icu \
        libjpeg-turbo \
        libpng \
        libxml2 \
        sudo \
        shadow \
    && if [ -f "/usr/local/sbin/php-fpm" ]; then \
        apk --no-cache add nginx; \
    fi \
#
# Configure php
#
    && apk --no-cache add --virtual .build-deps $PHPIZE_DEPS \
        autoconf \
        freetype-dev \
        icu-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        tzdata \
        zlib \
    && docker-php-ext-configure intl \
    && docker-php-ext-configure gd \
        --with-freetype \
        --with-jpeg \
    && NUMPROC=$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) \
    && docker-php-ext-install -j${NUMPROC} \
        bcmath \
        gd \
        intl \
        opcache \
        pcntl \
        pdo_mysql \
    && if [ ${PHP_XDEBUG_ENABLE} = 1 ]; then \
        pecl install xdebug \
        && docker-php-ext-enable xdebug; \
    fi \
    && pecl install \
        redis \
    && docker-php-ext-enable \
        redis \
    && mv "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini" \
#
# Configure timezone
#
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo ${TIMEZONE} > /etc/timezone \
#
# Remove usuless packages
#
    && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
    && apk del .build-deps \
#
# Create user
#
    && (getent group ${PGID}} || addgroup -g ${PGID} dset) \
    && export GROUPNAME=$(getent group "$PGID" | cut -d: -f1) \
    && adduser -u ${PUID} -D -G ${GROUPNAME} ${USERNAME} \
    && chown -R ${USERNAME}:${GROUPNAME} ${APP_PATH} \
    && chown -R ${USERNAME}:${GROUPNAME} /home/${USERNAME} \
    && if [ -f "/usr/local/sbin/php-fpm" ]; then \
        usermod -aG "nginx,www-data" ${USERNAME}; \
    fi \
    && echo "$USERNAME ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
#
# Clean Alpine
#
    && apk del shadow \
    && rm -rf \
        /usr/includes/* \
        /usr/local/lib/php/doc/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/*

#
# Add files
#
# COPY --from=mhart/alpine-node:${NODE_VERSION} /usr/include/node /usr/include/node
# COPY --from=mhart/alpine-node:${NODE_VERSION} /usr/lib/node_modules/npm /usr/lib/node_modules/npm
# COPY --from=mhart/alpine-node:${NODE_VERSION} /usr/local/share/yarn /usr/local/share/yarn
COPY ./php/configs/opcache.ini /tmp/opcache.ini
COPY ./php/configs/xdebug.ini /tmp/xdebug.ini
COPY ./php/configs/php.ini /tmp/php.ini
COPY ./php/configs/www.conf /tmp/www.conf
COPY ./php/configs/start.sh /home/start.sh
COPY ./php/configs/nginx.conf /etc/nginx/nginx.conf

#
# Customize
#
RUN envsubst < /tmp/opcache.ini | sudo tee -a ${PHP_CONF_DIR}/opcache.ini \
    && envsubst < /tmp/xdebug.ini | sudo tee -a ${PHP_CONF_DIR}/xdebug.ini \
    && envsubst < /tmp/php.ini | sudo tee -a ${PHP_CONF_DIR}/php.ini \
    && if [ -f "/usr/local/sbin/php-fpm" ]; then \
        envsubst < /tmp/www.conf | sudo tee -a ${PHP_FPM_POOL_DIR}/www.conf \
        && sed -i "s/{{ NGINX_CLIENT_MAX_BODY_SIZE }}/${PHP_UPLOAD_MAX_FILESIZE}/" /etc/nginx/nginx.conf \
        && sed -i "s/{{ NGINX_LISTEN_PORT }}/${NGINX_LISTEN_PORT}/" /etc/nginx/nginx.conf \
        && sed -i "s|{{ NGINX_ROOT }}|${NGINX_ROOT}|" /etc/nginx/nginx.conf \
        && mkdir -p /run/nginx \
        && touch /run/nginx/nginx.pid \
        && touch /run/php-fpm.pid \
        && touch /var/log/nginx/error.log \
        && chown ${USERNAME}:${GROUPNAME} /run/nginx/nginx.pid \
        && chown ${USERNAME}:${GROUPNAME} /run/php-fpm.pid \
        && chown -R ${USERNAME}:${GROUPNAME} /run/nginx \
        && chown -R ${USERNAME}:${GROUPNAME} /var/log/nginx \
        && chown -R ${USERNAME}:${GROUPNAME} /var/lib/nginx; \
    fi \
    && chown ${USERNAME}:${GROUPNAME} /home/start.sh \
    && chmod +x /home/start.sh \
    && chown -R ${USERNAME}:${GROUPNAME} /home/${USERNAME} \
    && rm -rf /tmp/*

# Expose webserver port
EXPOSE ${NGINX_LISTEN_PORT}

# User
USER ${USERNAME}

# Start nginx & php-fpm or enter into bash shell (cli)
CMD [ "/home/start.sh" ]
