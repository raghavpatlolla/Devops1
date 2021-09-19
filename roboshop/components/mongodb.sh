#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log
HEAD  "Setting up MongoDB repo "
echo "[mongodb-org-5.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/amazon/2/mongodb-org/5.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-5.0.asc">/etc/yum.repos.d/mongodb-org-5.0.repo
STAT $?
HEAD  "Installing  MongoDB  "
yum install -y mongodb-org &>>$log
STAT $?
HEAD  "Enabling and starting  MongoDB "
systemctl enable mongod && systemctl start mongod &>>$log
STAT $?
HEAD  "Installing  MongoDB  "
sed -i -e "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf &>>$log
STAT $?
HEAD  "Restarting  MongoDB "
systemctl restart mongod &>>$log
STAT $?
HEAD  "Downloading data from Github"
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/mongodb/archive/main.zip" &>>$log
STAT $?
HEAD  "Unzipping  zip file"
unzip /tmp/mongodb.zip  &>>$log
STAT $?
HEAD  "Loading data to DB"
mongo < /tmp/mongodb-main/catalogue.js && mongo < /tmp/mongodb-main/users.js &>>$log
STAT $?