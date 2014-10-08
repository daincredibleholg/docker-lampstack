#!/bin/bash
if [ ! -f /mysql-configured ]; then
	/usr/bin/mysqld_safe & 
	sleep 10s
	MYSQL_PASSWORD=`pwgen -c -n -1 12`
	echo mysql root password: $MYSQL_PASSWORD
	echo $MYSQL_PASSWORD > /mysql-root-pw.txt
	mysqladmin -u root password $MYSQL_PASSWORD 
	mysql -e "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
	touch /mysql-configured
	killall mysqld
	sleep 10s
fi
supervisord -n
