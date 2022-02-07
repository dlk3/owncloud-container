#!/usr/bin/env sh

if [ ! -d "/var/run/redis" ]; then
	mkdir /var/run/redis
fi
/usr/bin/redis-server /etc/redis/redis.conf --daemonize yes

if [ ! -d "/run/php-fpm" ]; then
	mkdir /run/php-fpm
fi
/usr/sbin/php-fpm

/usr/sbin/httpd -DFOREGROUND
