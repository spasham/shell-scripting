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

# echo -n "Configuring the $APP repo :"
# curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
# stat $? 

cat >/etc/yum.repos.d/$APP.repo <<EOL
[mongodb-org-4.2]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/4.2/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-4.2.asc
EOL

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
stat $?

echo -n "Injecting the schema into $APP: "
cd /tmp/$APP-main
mongod < catalogue.js &>>$LOGFILE
mongod < users.js >>$LOGFILE
stat $?


