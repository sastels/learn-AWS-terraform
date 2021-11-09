#!/bin/bash
sudo su - root

# update ubuntu

apt update
apt -y upgrade

# Apache, php, mysql

apt -y install apache2 libapache2-mod-php php-mysql
echo "<h1> My web server!! </h1>" > /var/www/html/index.html

# Wordpress

curl https://wordpress.org/latest.tar.gz | tar zx -C /var/www/html


