#!/bin/bash

#COMPONENT=$1

#if [ -z "$1" ]
#  then
#  echo -e " component name as an argument is mandatory \t\t"
#  exit 1
#fi

rm -rf akey*

KEY_PAIR=$(aws ec2 create-key-pair --key-name akey --query 'KeyMaterial' --output text > akey.pem)

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" |jq ".Images[].ImageId" |sed -e 's/"//g')

echo $AMI_ID

echo "Launching AWS ec2 Instance.."

#SYNTAX: aws ec2 run-instances [other options] --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyInstanceName}]'

aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --key-name akey  --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=cliserver}]'|jq
