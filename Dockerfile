# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lborges- <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/02/18 11:44:32 by lborges-          #+#    #+#              #
#    Updated: 2020/02/27 11:21:48 by lborges-         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Download and use the OS
FROM debian:buster

#Label
LABEL ft_server="Setting a web server. By: lborges-"

## Retira as iterações da instalação
ARG DEBIAN_FRONTEND=noninteractive
## Remove os erros de invoke (couldn´t determine current runlevel ou 
## restart permission)
RUN printf "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d

# Command to copy the script to the container
COPY /srcs/ /root/

#Installing Updates and Tools for Debian 
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y --no-install-recommends apt-utils
RUN apt-get -y install wget aptitude

#Install SSL
RUN apt-get -y install openssl

#Install Mysql
RUN aptitude -y install mariadb-server

#Install Nginx
RUN apt-get -y install nginx

#Install PHP
RUN apt-get -y install php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-json php-mbstring php7.3-mbstring php-curl php-gd php-intl php-soap php-xml php-xmlrpc php-zip

#Run configure
RUN bash /root/install_config.sh

#Starting Services
ENTRYPOINT bash /root/run.sh
 
#Running the container indefinitely
CMD tail -f /dev/null
