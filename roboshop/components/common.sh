HEAD(){
  echo -n -e "\e[1m $1 \e[0m \t\t ... "
}

STAT(){
  if [ $1 -eq 0 ]; then
    echo -e "\e[1;32m SUCCESS \e[0m"

  else
    echo -e "\e[1;31m FAILED \e[0m"
    echo -e "\e[1;33m Check the log for more details...Log-file: /tmp/roboshop.log\e[0m"
    exit 1
  fi

}

ADD_USER(){
HEAD  "Adding user roboshop "
id roboshop &>>$log
if [ $? -eq 0 ] ; then
  echo "user roboshop already exists"&>>$log
 else
useradd roboshop &>>$log
fi
STAT $?
}
NODEJS(){
HEAD  "Setting up $1 pre-requisites "
curl -fsSL https://rpm.nodesource.com/setup_16.x | bash - &>>$log
STAT $?

HEAD  "Installing nodejs"
yum install -y nodejs &>>$log
STAT $?
HEAD  "Installing gcc-c++ make "
yum install gcc-c++ make -y &>>$log
STAT $?


HEAD  "Download $1 app from Github "
curl -s -L -o /tmp/$1.zip "https://github.com/roboshop-devops-project/$1/archive/main.zip"&>>$log
STAT $?
HEAD  "Extracting and Setting up  $1 app  "
cd /home/roboshop && rm -rf $1 && unzip /tmp/$1.zip &>>$log && mv $1-main $1
STAT $?

HEAD  "Installing NodeJS dependencies"
cd /home/roboshop/$1 && npm install --unsafe-perm &>>$log
STAT $?

HEAD  "Fixing the permission issue"
chown -R  roboshop:roboshop /home/roboshop/ &>>$log
STAT $?

HEAD  "Setup systemd.service"
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/'   -e 's/REDIS_ENDPOINT/redis.roboshop.internal/'  -e 's/MONGO_ENDPOINT/mongodb.roboshop.internal/'
 /home/roboshop/$1/systemd.service &>>$log && mv /home/roboshop/$1/systemd.service /etc/systemd/system/$1.service &>>$log
STAT $?
HEAD  "Setup systemd.service"
 systemctl daemon-reload &&
 systemctl start $1 &>>$log &&
 systemctl enable $1  &>>$log
STAT $?
}

