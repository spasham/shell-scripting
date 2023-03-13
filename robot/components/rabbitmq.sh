#!/bin/bash 

# set -e 

COMPONENT=rabbbitmq
source components/common.sh 

echo -n "Installing and Configuring Dependency :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash   &>> $LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> $LOGFILE
stat $? 

echo -n "Installing $COMPONENT :"
yum install rabbitmq-server -y  &>> $LOGFILE 
stat $? 

echo -n "Starting $COMPONENT :"
systemctl enable rabbitmq-server  &>> $LOGFILE 
systemctl start rabbitmq-server   &>> $LOGFILE 

echo -n "Creating $COMPONENT Application User :"
rabbitmqctl add_user roboshop roboshop123  &>> $LOGFILE 
stat $?



# ```sql
# # rabbitmqctl add_user roboshop roboshop123
# # rabbitmqctl set_user_tags roboshop administrator
# # rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
# ```

# Ref link : [https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management](https://www.rabbitmq.com/rabbitmqctl.8.html#User_Management)

# 1. We are good with `[rabbitmq`.Next](http://rabbitmq.Next) component is `PAYMENT`