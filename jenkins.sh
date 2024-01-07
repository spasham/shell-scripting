#!/bin/bash

yum update -y
yum install java-11-openjdk-devel -y
yum install -y wget
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
yum install jenkins -y
systemctl start jenkins
systemctl enable jenkins
jenkins_psswd=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
echo $jenkins_psswd
