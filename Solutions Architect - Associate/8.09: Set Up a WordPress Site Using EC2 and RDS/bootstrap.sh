#!/bin/bash
sudo su - root

# update ubuntu

apt update
apt -y upgrade

# Apache, php, mysql

apt -y install apache2 libapache2-mod-php php-mysql
cat > /var/www/html/index.html <<EOF
<h1> My web server!! </h1>
Go to <a href="/wordpress">Wordpress</a>
EOF

# Wordpress

curl https://wordpress.org/latest.tar.gz | tar zx -C /var/www/html

chmod -R a+rwX /var/www
