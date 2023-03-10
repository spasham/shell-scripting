#!/bin/bash 

set -e 

# Validting whether the executed user is a root user or not 
ID=$(id -u)

if [ "$ID" -ne 0 ] ; then 
    echo -e "\e[31m You should execute this script as a root user or with a sudo as prefix \e[0m" 
    exit 1
fi 

echo -n "Installing Ngnix : "
yum install nginx -y &>> /tmp/frontend.log

if [ $? -eq 0 ] ; then 
    echo -e "\e[32m Success \e[0m"
else 
    echo -e "\e[31m Failure \e[0m"
fi 

curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"

cd /usr/share/nginx/html
rm -rf *  &>> /tmp/frontend.log
unzip /tmp/frontend.zip  &>> /tmp/frontend.log 
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf

systemctl enable nginx  &>> /tmp/frontend.log
systemctl restart nginx &>> /tmp/frontend.log



# # Here are my 3 observations :
# 1) Few of the steps are failed, still my script executed irrespective of the failure.  : set -e 
# 2) Installation failed because I've not validated that I've root privileges 
# 3) The information I would like to provide is like Sucess or Failure