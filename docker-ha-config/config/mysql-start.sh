#!/bin/sh
#rm -rf /var/lib/mysql/*
chown -R mysql:mysql /var/lib/mysql
usermod -d /var/lib/mysql mysql
service mysql start
tail -f /var/log/mysql/error.log

