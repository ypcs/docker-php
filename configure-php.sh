#!/bin/sh
set -e

cat > "/etc/php/${PHP_VERSION}/fpm/pool.d/zz-docker.conf" << EOF
[global]
error_log = /dev/stderr

[www]
access.log = /dev/stdout
clear_env = no
catch_workers_output = yes
EOF

mkdir -p /run/php

if [ -d "/etc/php${PHP_VERSION}" ]
then
    mkdir -p /etc/php
    ln -sf "/etc/php${PHP_VERSION}" "/etc/php/${PHP_VERSION}"
fi

# Listen 9000/tcp
sed -i "s/^listen = .*/listen = 9000/g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Don't daemonize
sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/${PHP_VERSION}/fpm/php-fpm.conf

# Create symlink if using different naming scheme
if [ -x "/usr/sbin/php${PHP_VERSION}-fpm" ]
then
    ln -sf "/usr/sbin/php${PHP_VERSION}-fpm" "/usr/sbin/php-fpm${PHP_VERSION}"
fi

