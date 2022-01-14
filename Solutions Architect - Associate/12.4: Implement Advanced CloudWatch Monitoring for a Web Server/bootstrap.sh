#!/bin/bash
server_id="${server_id}"

sudo su
yum -y update
yum -y upgrade
yum -y install httpd

# Configure Cloudwatch agent

sudo yum install amazon-cloudwatch-agent

# wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
# rpm -U ./amazon-cloudwatch-agent.rpm

# Use cloudwatch config from SSM
/opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
-a fetch-config \
-m ec2 \
-c ssm:${ssm_cloudwatch_config} -s

echo "<h1> Web server $server_id </h1>" >> /var/www/html/index.html
systemctl enable httpd
systemctl start httpd

echo 'Done initialization'
