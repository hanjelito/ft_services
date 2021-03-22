#! /bin/sh
mariadb-install-db -u root
mysqld -u root & sleep 5
mysql -u root --execute="CREATE DATABASE wordpress;"
mysql -u root wordpress < wordpress.sql
mysql -u root --execute="CREATE USER 'root'@'%' IDENTIFIED BY '123456'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION; USE wordpress; FLUSH PRIVILEGES;"
telegraf & sleep infinite
