#!/bin/bash
sudo su - root
yum -y update

# Web server

yum -y install httpd

echo "<h1> My web server!! </h1>" >> /var/www/html/index.html
curl ifconfig.me >> /var/www/html/index.html
echo "\n" >> /var/www/html/index.html

systemctl enable httpd
systemctl start httpd
