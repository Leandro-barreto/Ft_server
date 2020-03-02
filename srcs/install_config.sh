#! /bin/bash

# CRIA O DIRETÓRIO QUE SALVAREMOS OS ARQUVIOS E VAI PARA O ROOT 
mkdir /var/www/localhost
cd /root

#Configure Nginx
cp -pr /root/nginx.conf /etc/nginx/sites-available/default

# INSTALLING PHPMYADMIN
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.1/phpMyAdmin-4.9.1-english.tar.gz
tar -xf phpMyAdmin-4.9.1-english.tar.gz && rm -rf phpMyAdmin-4.9.1-english.tar.gz
mv phpMyAdmin-4.9.1-english /var/www/localhost/phpmyadmin
cp -pr ./config.inc.php /var/www/localhost/phpmyadmin/config.inc.php
chown -R www-data:www-data /var/www/localhost/phpmyadmin

# FAZ O SETUP DO SSL (C= COUNTRY, ST= STATE, LOCATION =)
# -x509 = Self signed certificate
#newkey rsa:2048 = RSA: Type of encrypt 2058: Number of bits
#subj= sets subject name for new request or supersedes the subject name when processing a request. The arg must be formatted as /type0=value0/type1=value1/type2=..., characters may be escaped by \ (backslash), no spaces are skipped.
#keyout= this gives the filename to write the newly created private key to
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-subj '/C=BR/ST=SP/L=SP/O=42/CN=lborges' \
	-keyout /etc/ssl/certs/localhost.key -out /etc/ssl/certs/localhost.crt

#Configure Maria-DB
service mysql start
echo "CREATE DATABASE wpbase DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mysql -u root
mysqladmin --user=root password "lborges"

#Configure and Download Wordpress
mv wordpress /var/www/localhost/
