#!/bin/bash
echo "I'm frontend"

#set -e          #if any error occurs script will get exited

APP=frontend
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
echo -n "Installing nginx: "
yum install nginx -y &>>$LOGFILE

stat $?

echo -n "Downling the $APP code: "
curl -s -L -o /tmp/$APP.zip "https://github.com/roboshop-devops-project/$APP/archive/main.zip"
stat $?

echo -n "Performing cleanup of old $APP conetnet:"
cd /usr/share/nginx/html  
rm -rf * &>>$LOGFILE
stat $?

echo -n "Copying the $APP code:"
unzip /tmp/$APP.zip &>>$LOGFILE
mv $APP-main/* .
mv static/* .
rm -rf $APP-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
stat $?

echo -n "Starting and enabling the service:"
systemctl start nginx &>>$LOGFILE
systemctl enable nginx &>>$LOGFILE
stat $?