#!/bin/bash
sudo su - root

# update

yum update -y

# postgres

amazon-linux-extras install postgresql10

# install other packages

amazon-linux-extras install -y php7.4 # was php7.2
yum install -y httpd mysql

# tweak groups and file ownership

usermod -a -G apache ec2-user
chown -R ec2-user:apache /var/www
chmod 2775 /var/www && find /var/www -type d -exec sudo chmod 2775 {} \;
find /var/www -type f -exec sudo chmod 0664 {} \;

# start apache

systemctl start httpd
systemctl enable httpd

# simple home page

cat > /var/www/html/index.html <<EOF
<h1> My web server!! </h1>
EOF

# download sample database

# cd /tmp
# curl -o dvdrental.zip  https://www.postgresqltutorial.com/wp-content/uploads/2019/05/dvdrental.zip
# unzip dvdrental.zip
