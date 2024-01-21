#!/bin/bash

# RMIT University Vietnam
# Course: COSC2767 Systems Deployment and Operations
# Semester: 2023C
# Assessment: Assignment 3
# Author: Group 3
# Created  date: 02/01/2023
# Last modified: 20/01/2023
# Acknowledgement: None

#install docker
sudo yum install docker -y

#add ansibleadmin user
useradd ansibleadmin

#set password for ansibleadmin as 123
echo "123" | passwd --stdin ansibleadmin

#add ansibleadmin to docker group
sudo usermod -aG docker ansibleadmin

#in /etc/sudoers, add "ansibleadmin ALL=(ALL) NOPASSWD: ALL" so that ansibleadmin can run sudo command without password
echo "ansibleadmin ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

#in /etc/ssh/sshd_config, change "PasswordAuthentication no" to "PasswordAuthentication yes" to turn on password authentication in ssh
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

#restart sshd for change to take effect
service sshd reload
