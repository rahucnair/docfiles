#!/bin/bash
service mysql start &
sleep 10
# Enabling autologin for root  

printf "[client]\nuser=root\npassword=drupal123" >> /root/.my.cnf 
chmod 400 /root/.my.cnf 

# Creating database and users 
DB=drupal
USER=drupal_admin
PASS=drupal123

mysql -uroot <<MYSQL_SCRIPT
CREATE DATABASE $DB;
CREATE USER '$USER'@'%' IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON $DB.* TO '$USER'@'%';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "MySQL user created."
echo "Username:   $USER"
echo "Password:   $PASS"


# Deploying database
cd /tmp
mysql -u root drupal < drupal-dump.sql
rm -rf /tmp/*
tailf /var/log/mysql/error.log
