#!/bin/bash


service=vsftpd

hostname

if (( $(ps -ef | grep -v grep | grep $service | wc -l) > 0 ))
then
echo "$service is running"
else
echo "Service is not running, hence starting it now..."
systemctl start vsftpd
echo "service started..!!"
systemctl status vsftpd

fi
