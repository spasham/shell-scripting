#!/bin/bash
echo "I'm frontend"

#set -e          #if any error occurs script will get exited


#validating if executed user is root or not

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "You should execute this script as root user or wiht sudo access"
    exit 1
fi

echo -n "Installing nginx: "
yum install nginx -y &>>/tmp/frontend.log
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo -e "\e[31m Failure \e[0m"
    exit 2
fi

echo -n "Downling the frontend code: "
curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

if [ $? -eq 0 ]; then
    echo "Success"
else
    echo -e "\e[31m Failure \e[0m"
    exit 2
fi
echo -n "Performing cleanup of old frontend conetnet:"
cd /usr/share/nginx/html  
rm -rf * &>>/tmp/frontend.log

if [ $? -eq 0 ]; then
    echo "Success"
else
    echo -e "\e[31m Failure \e[0m"
    exit 2
fi

echo -n "Copying the frontend code:"
unzip /tmp/frontend.zip &>>/tmp/frontend.log
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo -e "\e[31m Failure \e[0m"
    exit 2
fi

echo -n "Starting and enabling the service:"
systemctl start nginx &>>/tmp/frontend.log
systemctl enable nginx &>>/tmp/frontend.log
if [ $? -eq 0 ]; then
    echo "Success"
else
    echo -e "\e[31m Failure \e[0m"
    exit 2
fi