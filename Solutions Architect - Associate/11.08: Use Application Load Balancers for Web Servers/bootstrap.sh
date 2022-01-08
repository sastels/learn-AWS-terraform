#!/bin/bash
server_id="${server_id}"

sudo su
yum -y update
yum -y install httpd
echo "<h1> Web server $server_id </h1>" >> /var/www/html/index.html
systemctl enable httpd
systemctl start httpd
