#! /bin/bash

service nginx start >> /dev/null
service mysql start >> /dev/nul
service php7.3-fpm start >> /dev/null

tail -f /var/log/nginx/access.log
