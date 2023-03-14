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

# This should only run for the first time or when the default password is not changed.
echo "show databases;" | mysql -uroot -pRoboShop@1   &>> $LOGFILE 
if [ $? -ne 0 ] ; then 

    echo -n "Password Reset of root user :"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED BY 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PWD} &>> $LOGFILE 
    stat $?

fi 

echo -n "Uninstalling Password Validation Plugin :"
echo "uninstall plugin validate_password;" | mysql -uroot -pRoboShop@1   &>> $LOGFILE
stat $?




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