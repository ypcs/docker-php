FROM ypcs/php:latest

ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF

ENV WEBGRIND_VERSION 1.5.0

RUN \
    /usr/local/sbin/docker-upgrade && \
    apt-get --assume-yes install \
        curl \
        php${PHP_VERSION}-xdebug && \
    /usr/local/sbin/docker-cleanup

RUN \
    curl -fSL "https://github.com/jokkedk/webgrind/archive/v${WEBGRIND_VERSION}.tar.gz" -o /tmp/webgrind.tar.gz && \
    mkdir -p /opt/webgrind
    cd /opt/webgrind && \
    tar -xzf /tmp/webgrind.tar.gz --strip-components=1 && \
    rm -f /tmp/webgrind.tar.gz

