#
# VERSION
#
ARG NODE_VERSION=14.16

#
# Node Image for App
#
FROM mhart/alpine-node:${NODE_VERSION}

#
# Author
#
LABEL maintainer="Gilberto Junior <olamundo@gmail.com>"

#
# Default values
#
ARG APP_PATH=/var/www/app
ARG GROUPNAME=dset
ARG PUID=1000
ARG PGID=1000
ARG USERNAME=you
ARG TIMEZONE=UTC

#
# Environment variables
#
ENV APP_PATH=${APP_PATH} \
    GROUPNAME=${GROUPNAME} \
    PGID=${PGID} \
    PUID=${PUID} \
    PS1="\u@${GROUPNAME}:\\$ " \
    TIMEZONE=${TIMEZONE} \
    USERNAME=${USERNAME}

#
# Workdir
#
WORKDIR ${APP_PATH}

RUN set -ex \
#
# Install Packages
#
    && apk --no-cache add \
        bash \
        curl \
        git \
        gettext \
        sudo \
#
# Configure sudo
#
    && echo "Set disable_coredump false" >> /etc/sudo.conf \
#
# Configure timezone
#
    && apk --no-cache add \
        tzdata \
    && cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime \
    && echo ${TIMEZONE} > /etc/timezone \
    && apk del \
        tzdata \
#
# Remove usuless packages
#
    && { find /usr/local/lib -type f -print0 | xargs -0r strip --strip-all -p 2>/dev/null || true; } \
#
# Create user
#
    && (getent group ${PGID}} || addgroup -g ${PGID} ${GROUPNAME}) \
    && export GROUPNAME=$(getent group "$PGID" | cut -d: -f1) \
    && adduser -u ${PUID} -D -G ${GROUPNAME} ${USERNAME} \
    && chown -R ${USERNAME}:${GROUPNAME} ${APP_PATH} \
    && chown -R ${USERNAME}:${GROUPNAME} /home/${USERNAME} \
    && echo "$USERNAME ALL = ( ALL ) NOPASSWD: ALL" >> /etc/sudoers \
#
# Clean Alpine
#
    && rm -rf /tmp/* \
        /root/.gnupg \
        /root/.node-gyp \
        /root/.npm \
        /usr/includes/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/*

# Expose webserver port
EXPOSE 8080

USER ${USERNAME}
