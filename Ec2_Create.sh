#!/bin/bash


if [ -z "$1" ]
  then
  echo -e " provide APP name as command line arguement \t\t"
  exit 1
fi


APP=$1

rm -rf akey*

sg=$(aws ec2 create-security-group --group-name iSec --description "My default security")
sg_id=$(aws ec2 describe-security-groups |jq ".SecurityGroups[].GroupId" |sed -e 's/"//g' | tail -n1)

aws ec2 authorize-security-group-ingress --group-id $sg_id --protocol tcp --port 22 --cidr 0.0.0.0/0 


KEY_PAIR=$(aws ec2 create-key-pair --key-name akey --query 'KeyMaterial' --output text > akey.pem)

AMI_ID=$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" |jq ".Images[].ImageId" |sed -e 's/"//g')

echo $AMI_ID

echo "Launching AWS ec2 Instance.."

#SYNTAX: aws ec2 run-instances [other options] --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=MyInstanceName}]'

aws ec2 run-instances --image-id $AMI_ID --instance-type t2.micro --key-name akey  --security-group-ids $sg_id --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$APP}]"|jq
