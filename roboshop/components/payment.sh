#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log



HEAD  "Installing PIP"
 yum install python36 gcc python3-devel -y &>>$log &&
yum install python3-pip -y &>>$log &&
pip3 install pip --upgrade &>>$log
STAT $?

ADD_USER

HEAD  "Download payment app from Github "
curl -s -L -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip"&>>$log
STAT $?
HEAD  "Extracting and Setting up  payment app  "
cd /home/roboshop && rm -rf payment && unzip /tmp/payment.zip &>>$log && mv payment-main payment
STAT $?
HEAD  "Fixing the permission issue"
chown -R  roboshop:roboshop /home/roboshop/ &>>$log
STAT $?

USER_ID=$(id -u roboshop)
GRP_ID=$(id -g roboshop)

HEAD  "Update uid and gid in payment.ini"
sed -i -e "/uid/ c uid={USER_ID" -e "/gid/ c gid={GRP_ID" /home/roboshop/payment/payment.ini &>>$log
STAT $?


HEAD  "Installing requirements using pip3"
cd /home/roboshop/payment &&
pip3 install -r requirements.txt  &>>$log
STAT $?

SET_SYSTEMD_SERVICE "payment"