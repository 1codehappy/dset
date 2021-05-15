#
# VERSIONS
#
ARG PHP_VERSION=8.0

#
# PHP Official Image
#
FROM php:${PHP_VERSION}-cli-alpine

#
# Author
#
LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

#
# Default values
#
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

#
# Environment variables
#
ENV APP_PATH=${APP_PATH} \
    PGID=${PGID} \
    PUID=${PUID} \
    PHP_INI_DIR=/usr/local/etc/php \
    PHP_CONF_DIR=/usr/local/etc/php/conf.d \
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
    PHP_OPCACHE_FAST_SHUT_DOWN=${PHP_OPCACHE_FAST_SHUT_DOWN}

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
        shadow \
        sudo \
#
# Configure php
#
    && apk --no-cache add --virtual .build-deps $PHPIZE_DEPS \
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
    && if [ ${PHP_XDEBUG_ENABLE} = true ]; then \
        pecl install xdebug \
        && docker-php-ext-enable xdebug; \
    fi \
    && pecl install \
        redis \
    && docker-php-ext-enable \
        redis \
    && mv "${PHP_INI_DIR}/php.ini-production" "${PHP_INI_DIR}/php.ini" \
#
# Install composer
#
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
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
    && echo "$USERNAME ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
#
# Clean Alpine
#
    && rm -rf \
        /tmp/* \
        /usr/includes/* \
        /usr/local/lib/php/doc/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/*

#
# Add files
#
COPY ./php/configs/opcache.ini ${PHP_CONF_DIR}/opcache.ini
COPY ./php/configs/xdebug.ini ${PHP_CONF_DIR}/xdebug.ini
COPY ./php/configs/php.ini ${PHP_CONF_DIR}/php.ini

#
# Customize
#
RUN envsubst ${PHP_CONF_DIR}/opcache.ini \
    && envsubst ${PHP_CONF_DIR}/xdebug.ini \
    && envsubst ${PHP_CONF_DIR}/php.ini

#
# Customize
#
RUN envsubst ${PHP_CONF_DIR}/opcache.ini \
    && envsubst ${PHP_CONF_DIR}/xdebug.ini \
    && envsubst ${PHP_CONF_DIR}/php.ini

USER ${USERNAME}
