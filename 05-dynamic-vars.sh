#!/bin/bash 

TODAYDATE=$(date +%F)  # This way of declaring is called as hardcoding.

echo -e "Welcome to Bash Training, Today date is \e[32m ${TODAYDATE} \e[0m"
echo "Number of users sessions in the system are : $(who | wc -l) 