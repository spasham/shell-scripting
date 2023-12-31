#!/bin/bash
echo "I am mongodb service"


#set -e          #if any error occurs script will get exited

APP=mongo
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
cat >/etc/yum.repos.d/mongodb.repo <<EOL
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


