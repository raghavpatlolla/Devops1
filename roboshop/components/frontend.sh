#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log
HEAD  "Installing NGINX"
amazon-linux-extras install nginx1&>>$log
yum install nginx -y &>>$log
STAT $?
HEAD  "Enabling and starting NGINX"
systemctl enable nginx && systemctl start nginx &>>$log
STAT $?

HEAD  "Download frontend from github"
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"
STAT $?
