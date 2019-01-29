#!/bin/sh
set -v
service nginx start
service	php7.2-fpm start

tail -F /var/log/nginx/error.log
