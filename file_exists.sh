#!/bin/bash
file="/Users/spasham/Documents/learning/test"

# check
if [ -e $file ]
then
  echo "File exists!"
else
  echo "File does not exists!"
fi


if [ -x $file ] 
then
  echo "you have executable permissions"
else
  echo "you do not have executable permissions"
fi

