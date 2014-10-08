FROM ubuntu:latest
MAINTAINER Holger Steinhauer <hlibrenz@gmail.com>
RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-client mysql-server apache2 libapache2-mod-php5 pwgen python-setuptools php5-mysql php5-common php5-curl php5-gd php5-geoip php5-imagick php5-imap php5-intl php5-ldap php5-mcrypt php5-memcache php5-tidy php5-xmlrpc php5-xsl vim
RUN easy_install supervisor
# Let MySQL listen to the whole world - this is absolutely fine for _DEV only_ environments.
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
ADD ./000-default.conf /etc/apache2/sites-available/000-default.conf
ADD ./start.sh /start.sh
ADD ./foreground.sh /etc/apache2/foreground.sh
ADD ./supervisord.conf /etc/supervisord.conf
RUN chmod 755 /start.sh
RUN chmod 755 /etc/apache2/foreground.sh
EXPOSE 80
EXPOSE 3306
CMD ["/bin/bash", "/start.sh"]
