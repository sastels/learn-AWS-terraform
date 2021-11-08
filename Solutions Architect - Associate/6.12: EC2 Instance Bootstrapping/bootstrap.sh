#!/bin/bash
sudo su
yum -y update
yum -y install httpd
echo "<h1> My web server!! </h1>" >> /var/www/html/index.html
systemctl enable httpd
systemctl start httpd
