#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log
HEAD  "Installing Maven"
yum install maven -y &>>$log
STAT $?
ADD_USER
HEAD  "Downloading from Github "
 cd /home/roboshop &&
 curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip" &&
 unzip /tmp/shipping.zip  &>>$log &&
 mv shipping-main shipping &&
 cd shipping &&
  STAT $?

 HEAD  "Maven build "
  mvn clean package &>>$log &&
  mv target/shipping-1.0.jar  /home/roboshop/shipping/shipping.jar &>>$log
 STAT $?
