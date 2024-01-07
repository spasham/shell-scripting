#! /bin/bash

<<Comment
Exercise_11 - Write a script that executes the command “cat/etc/shadow”. 
If the command return a 0 exit status, report “command succeeded” and exit with a 0 exit status. 
If the command returns a non-zero exit status, report “Command failed” and exit with a 1 exit status.
Comment

cat /etc/shadow &>out.txt

if [ $? -eq 0 ]
   then
   echo "Command Succedded"
   exit 0

elif [ $? -ne 0 ]
   then
   echo "Command failed"
   exit 1

else
   echo "thank you"

fi
