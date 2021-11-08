#!/bin/bash
sleep 5m
sudo su - root
yum -y update
yum -y install httpd

yum install -y amazon-efs-utils
mkdir /efs
efs_id="${efs_id}"
mount -t efs $efs_id:/ /var/www/html
echo $efs_id:/ /var/www/html efs defaults,_netdev 0 0 >> /etc/fstab

echo "<h1> My web server!! </h1>" >> /var/www/html/index.html
curl ifconfig.me >> /var/www/html/index.html
systemctl enable httpd
systemctl start httpd

