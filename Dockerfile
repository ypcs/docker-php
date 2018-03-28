FROM ypcs/debian:jessie

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

ENV PHP_VERSION 5

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        msmtp-mta \
        php-db \
    	php${PHP_VERSION}-fpm && \
    /usr/local/sbin/docker-cleanup

RUN mkdir -p /docker-entrypoint-init.d
COPY entrypoint.sh /entrypoint.sh

COPY configure-php.sh /usr/local/sbin/configure-php
RUN /usr/local/sbin/configure-php

RUN echo "Source: https://github.com/ypcs/docker-php\nBuild date: $(date --iso-8601=ns)" >/README

ENTRYPOINT ["/entrypoint.sh"]
CMD ["sh", "-c", "php-fpm${PHP_VERSION}"]
