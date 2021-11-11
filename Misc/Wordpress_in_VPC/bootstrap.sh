#!/bin/bash
sudo su - root

# update

yum update -y

# install other packages

amazon-linux-extras install -y php7.2
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
Go to <a href="/wordpress">Wordpress</a>
EOF

# Wordpress

curl https://wordpress.org/latest.tar.gz | tar zx -C /var/www/html
chmod -R a+rwX /var/www
