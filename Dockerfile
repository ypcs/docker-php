FROM ypcs/debian:buster

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

ENV PHP_VERSION 7.3

RUN /usr/lib/docker-helpers/apt-setup && \
    /usr/lib/docker-helpers/apt-upgrade && \
    apt-get --assume-yes install \
        msmtp-mta \
    	php${PHP_VERSION}-fpm && \
    /usr/lib/docker-helpers/apt-cleanup

RUN mkdir -p /docker-entrypoint-init.d
COPY entrypoint.sh /entrypoint.sh

COPY configure-php.sh /usr/local/sbin/configure-php
RUN /usr/local/sbin/configure-php

RUN echo "Source: https://github.com/ypcs/docker-php\nBuild date: $(date --iso-8601=ns)" >/README

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh", "-c", "php-fpm${PHP_VERSION}"]
