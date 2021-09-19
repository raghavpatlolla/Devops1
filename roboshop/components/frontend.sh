#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log
HEAD  "Installing NGINX"
yum install nginx -y &>>$log
STAT $?