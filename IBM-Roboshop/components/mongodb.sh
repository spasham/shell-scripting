#!/bin/bash
#set -e          #if any error occurs script will get exited

APP=mongodb
LOGFILE=/tmp/$APP.log
#validating if executed user is root or not

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "You should execute this script as root user or wiht sudo access"
    exit 1
fi

stat() {
    if [ $1 -eq 0 ]; then
    echo "Success"
else
    echo -e "\e[31m Failure \e[0m"
    exit 2
fi
}

echo -n "Configuring the repo for $APP: "
cat >/etc/yum.repos.d/$APP.repo <<EOL
[mongodb-org-7.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/7.0/x86_64/
gpgcheck=0
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-7.0.asc
EOL

stat $?

echo -n "Installing $APP: "
yum install -y mongodb-org &>>$LOGFILE
stat $?

echo -n "Starting $APP service: "
systemctl start mongod
systemctl enable mongod
stat $?

echo -n "updating the localhost ip 127.0.0.1 to 0.0.0.0: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "performing daemon-reload: "
systemctl daemon-reload &>>$LOGFILE
systemctl restart mongod
stat $?

echo -n "Downloding $APP database schema: "
curl -s -L -o /tmp/mongodb.zip "https://github.com/roboshop-devops-project/$APP/archive/main.zip"
cd /tmp
unzip mongodb.zip &>>$LOGFILE
echo $(pwd)
stat $?

echo -n "Injecting the schema into $APP: "
cd /tmp/$APP-main
echo $(pwd)
mongod < catalogue.js &>>$LOGFILE
mongod < users.js >>$LOGFILE
stat $?


