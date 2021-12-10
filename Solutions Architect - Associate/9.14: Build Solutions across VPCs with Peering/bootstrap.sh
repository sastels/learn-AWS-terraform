#!/bin/bash
database_name="${db_name}"
username="${db_username}"
password="${db_password}"
host="${db_host}"

sudo apt update -y
sudo apt install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip perl mysql-server apache2 libapache2-mod-php php-mysql -y
wget https://github.com/ACloudGuru-Resources/course-aws-certified-solutions-architect-associate/raw/main/lab/5/wordpress.tar.gz
tar zxvf wordpress.tar.gz
cd wordpress
wget https://raw.githubusercontent.com/ACloudGuru-Resources/course-aws-certified-solutions-architect-associate/main/lab/5/000-default.conf
cp wp-config-sample.php wp-config.php
perl -pi -e "s/database_name_here/${db_name}/g" wp-config.php
perl -pi -e "s/username_here/${db_username}/g" wp-config.php
perl -pi -e "s/password_here/${db_password}/g" wp-config.php
perl -pi -e "s/localhost/${db_host}/g" wp-config.php
perl -i -pe'
  BEGIN {
    @chars = ("a" .. "z", "A" .. "Z", 0 .. 9);
    push @chars, split //, "!@#$%^&*()-_ []{}<>~\`+=,.;:/?|";
    sub salt { join "", map $chars[ rand @chars ], 1 .. 64 }
  }
  s/put your unique phrase here/salt()/ge
' wp-config.php
mkdir wp-content/uploads
chmod 775 wp-content/uploads
mv 000-default.conf /etc/apache2/sites-enabled/
mv /wordpress /var/www/
apache2ctl restart