#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log


HEAD  "Creating MySQL Repo"

echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
STAT $?
HEAD  "Installing  MySQL"
yum remove mariadb-libs -y  &>>$log && yum install mysql-community-server -y  &>>$log
STAT $?

SET_SYSTEMD_SERVICE "mysqld"

DEF_PASSWD=$(grep "A temporary password is" /var/log/mysqld.log|awk '{print $NF}')

echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';
uninstall plugin validate_password;" > /tmp/db.sql

HEAD  "Reset  MySQL password"
mysql -u root -p"${DEF_PASSWD}" </tmp/db.sql &>>$log
STAT $?