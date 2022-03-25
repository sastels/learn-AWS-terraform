#!/bin/bash
server_id="${server_id}"

sudo su
yum -y update
yum -y upgrade

# web server

yum -y install httpd

echo "<h1> Web server $server_id </h1>" >> /var/www/html/index.html
systemctl enable httpd
systemctl start httpd


# Cloudwatch agent

yum -y install amazon-cloudwatch-agent

/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c ssm:${ssm_cloudwatch_config} -s


echo 'Done initialization'
