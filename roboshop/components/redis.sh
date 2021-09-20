#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log
HEAD  "Setting up Redis pre-requisites "
amazon-linux-extras install epel -y &>>$log
STAT $?
HEAD  "Installing Redis "
yum install epel-release yum-utils -y &>>$log &&
rpm -qa | grep remi-release  || yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y &>>$log&&
yum-config-manager --enable remi &>>$log&&
yum install redis -y &>>$log
STAT $?
HEAD  "Update BindIP"
sed -i -e "s/127.0.0.1/0.0.0.0/" /etc/redis.conf  &>>$log &&
sed -i -e "s/127.0.0.1/0.0.0.0/"  /etc/redis/redis.conf  &>>$log
STAT $?
HEAD  "Start Redis Database"
systemctl enable redis &>>log && systemctl start redis &>>log
STAT $?
