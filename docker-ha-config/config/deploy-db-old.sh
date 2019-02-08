#!/bin/bash

rm -rf /var/lib/mysql/*
rm -rf /var/lib/mysql/.*
usermod -d /var/lib/mysql mysql
chown -R mysql:mysql /var/lib/mysql
service mysql start

#configuring databases
apt-get install expect -y

MYSQL_ROOT_PASSWORD=drupal123

SECURE_MYSQL=$(expect -c "
set timeout 10
spawn mysql_secure_installation
expect \"Would you like to setup VALIDATE PASSWORD plugin?\"
send \"n\r\"
expect \"New password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Re-enter new password:\"
send \"$MYSQL_ROOT_PASSWORD\r\"
expect \"Remove anonymous users? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"
expect \"Disallow root login remotely? (Press y|Y for Yes, any other key for No) :\"
send \"n\r\"
expect \"Remove test database and access to it? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"
expect \"Reload privilege tables now? (Press y|Y for Yes, any other key for No) :\"
send \"y\r\"
expect eof
")

echo "$SECURE_MYSQL"

apt-get -y remove expect

# Deploying database
cd /tmp
git clone https://github.com/rahucnair/docfiles.git
cd docfiles/

mysql -u root drupal < drupal-dump.sql

rm -rf /tmp/db-config.sh
rm -rf /tmp/docfiles

