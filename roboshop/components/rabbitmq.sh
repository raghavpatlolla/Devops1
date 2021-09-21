#!/bin/bash
source components/common.sh
log=/tmp/roboshop.log
rm -rf $log
HEAD  "Setting up rabbitmq pre-requisites "
rpm -qa | grep erlang  &>>$log || yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y  &>>$log
STAT $?

HEAD  "YUM repositories for RabbitMQ"

curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash  &>>$log
STAT $?
HEAD  "Install RabbitMQ"
yum install rabbitmq-server -y  &>>$log
STAT $?

HEAD  "Setup systemd.service"
 systemctl daemon-reload &&
 systemctl start rabbitmq-server &>>$log &&
 systemctl enable rabbitmq-server &>>$log
STAT $?

HEAD  "Create RabbitMQ application user"
rabbitmqctl add_user roboshop roboshop123 &>>$log && rabbitmqctl set_user_tags roboshop administrator &>>$log  && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$log
STAT $?

