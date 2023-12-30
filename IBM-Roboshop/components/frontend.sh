#!/bin/bash
echo "I'm frontend"

set -e          #if any error occurs script will get exited


#validating if executed user is root or not

USER_ID=$(id)

if [ $USER_ID -ne 0 ]
then
    echo "You should execute this script or wiht sudo access"
    exit 1
fi

yum install nginx -y

curl -s -L -o /tmp/frontend.zip "https://github.com/roboshop-devops-project/frontend/archive/main.zip"

cd /usr/share/nginx/html  
rm -rf *
unzip /tmp/frontend.zip
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl start nginx
systemctl enable nginx