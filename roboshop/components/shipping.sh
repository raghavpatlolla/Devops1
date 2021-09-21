#!/bin/bash
echo "Installing Shipping"


HEAD  "Downloading from Github password"
 curl -s -L -o /tmp/shipping.zip "https://github.com/roboshop-devops-project/shipping/archive/main.zip" &&
 unzip /tmp/shipping.zip  &>>$log &&
 mv shipping-main shipping &&
 cd shipping &&
  STAT $?

 HEAD  "Maven build "
  mvn clean package &>>$log
  mv target/shipping-1.0.jar ./shipping.jar
 issue  : jar shud be  in /home/roboshop/shipping/shipping.jar

 STAT $?