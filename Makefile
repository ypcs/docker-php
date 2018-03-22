FROM = ypcs/debian:stretch
PHP_VERSION = 7.0

all:

set-version:
	sed -i "s,^FROM .*,FROM $(FROM),g" Dockerfile
	sed -i "s,^ENV PHP_VERSION .*,ENV PHP_VERSION $(PHP_VERSION),g" Dockerfile
