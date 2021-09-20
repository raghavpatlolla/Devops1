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
yum install gcc-c++ make -y &>>$log
STAT $?

HEAD  "Adding user roboshop "
id roboshop &>>$log
if [ $? -eq 0 ] ; then
  echo "user roboshop already exists"&>>$log
 else
useradd roboshop &>>$log
fi
STAT $?
HEAD  "Download catalogue app from Github "
curl -s -L -o /tmp/catalogue.zip "https://github.com/roboshop-devops-project/catalogue/archive/main.zip"&>>$log
STAT $?
HEAD  "Download catalogue app from Github "
cd /home/roboshop && rm -rf catalogue && unzip /tmp/catalogue.zip &>>$log && mv catalogue-main catalogue
STAT $?

HEAD  "Installing NodeJS dependencies"
cd /home/roboshop/catalogue && npm install --unsafe-perm &>>$log
STAT $?

HEAD  "Fixing the permission issue"
chown -R  roboshop:roboshop /home/roboshop/ &>>$log
STAT $?

HEAD  "Update Mongodb DNS record in systemd.service"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' /home/roboshop/catalogue/systemd.service &>>$log && mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service &>>$log
STAT $?
HEAD  "Setup systemd.service"
 systemctl daemon-reload &&
 systemctl start catalogue &>>$log &&
 systemctl enable catalogue  &>>$log
STAT $?
