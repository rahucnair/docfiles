#!/bin/bash
cd /tmp
git clone https://github.com/rahucnair/docfiles.git
cd docfiles
rm -rf /var/www/html/drupal-docroot/.*
rm -rf /var/www/html/drupal-docroot/*
tar -xf docfiles/drupal-docroot_new.tar.gz -C /var/www/html/
chown -R www-data:www-data /var/www/html/drupal-docroot

