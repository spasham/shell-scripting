#!/bin/bash 

COMPONENT=mysql
source components/common.sh  


echo -n "Configuring the $COMPONENT repo :"
curl -s -L -o /etc/yum.repos.d/mysql.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo 
stat $?

echo -n "Installing the $COMPONENT :"
yum install mysql-community-server -y  &>> $LOGFILE  
stat $? 

echo -n "Starting $COMPONENT :"
systemctl enable mysqld  &>> $LOGFILE  
systemctl start mysqld   &>> $LOGFILE  
stat $?

echo -n "Grab $COMPONENT default password :"
DEFAULT_ROOT_PWD=$(grep "temporary password" /var/log/mysqld.log | awk '{print $NF}')
stat $? 

echo -n "Password Reset of root user :"
echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PWD} &>> $LOGFILE 
stat $?



# 1. Next, We need to change the default root password in order to start using the database service. Use password as `RoboShop@1` . Rest of the options you can choose `No`

# ```bash
# # mysql_secure_installation
# ```

# 1. You can check whether the new password is working or not using the following command in MySQL

# First let's connect to MySQL

# ```bash
# # mysql -uroot -pRoboShop@1
# ```

# Once after login to MySQL prompt then run this SQL Command. This will uninstall the password validation feature like number of characters, password length, complexty and all. As I don’t want that I’d be uninstalling the `validate_password` plugin

# ```sql
# > uninstall plugin validate_password;
# ```

# ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/584e54a9-29fa-4246-9655-e5666a18119b/Untitled.png)

# ## **Setup Needed for Application.**

# As per the architecture diagram, MySQL is needed by

# - Shipping Service

# So we need to load that schema into the database, So those applications will detect them and run accordingly.

# To download schema, Use the following command

# ```bash
# # curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
# ```

# Load the schema for mysql. This file contains the list of COUNTRIES, CITIES and their PINCODES. This will be helpful in doing the shipping charges calculation which is based on the distance the product is shippied