#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log
HEAD  "Setting up Catalogue pre-requisites "
curl -fsSL https://rpm.nodesource.com/setup_16.x | bash - &>>$log
STAT $?

HEAD  "Installing nodejs"
yum install -y nodejs &>>$log
STAT $?
HEAD  "Installing gcc-c++ make "
yum install gcc-c++ make &>>$log
STAT $?

HEAD  "Adding user roboshop "
useradd roboshop &>>$log
STAT $?
HEAD  "Download catalogue app from Github "
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"&>>$log
STAT $?
HEAD  "Download catalogue app from Github "
cd /home/roboshop && unzip /tmp/catalogue.zip &>>$log && mv catalogue-main catalogue
STAT $?

HEAD  "Installing NodeJS dependencies"
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$log
STAT $?

