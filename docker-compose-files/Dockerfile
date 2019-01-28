FROM ubuntu:latest
RUN apt-get update -y
RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get upgrade -y
RUN apt-get install apt-utils -y
RUN apt-get install -y openssl
RUN apt install -y vim curl wget zip unzip git
RUN apt-get install nginx -y
ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get install -y php php7.2-fpm php7.2-mbstring php7.2-mysql php7.2-gd php7.2-xml php7.2-zip php7.2-curl 
RUN mkdir -p /var/www/html/drupal-docroot/
#adding config files 
COPY config/www.conf /etc/php/7.2/fpm/pool.d/
COPY config/drupal-uniqueit-80.conf /etc/nginx/conf.d/
COPY config/service.sh /tmp/
COPY config/deploy-code.sh /tmp
COPY config/install-composer.sh /var/www/
# Installing composer
WORKDIR /var/www/
RUN usermod -s /bin/bash www-data
RUN sh install-composer.sh
RUN mv /var/www/composer.phar /usr/local/bin/composer
RUN composer --version 
RUN rm -rf /var/www/install-composer.sh

