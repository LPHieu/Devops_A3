#!/bin/bash

sudo yum install -y php php-mysql

sudo yum install -y httpd
sudo service httpd start
sudo systemctl enable httpd

#in /etc/ssh/sshd_config, change "PasswordAuthentication no" to "PasswordAuthentication yes" to turn on password authentication in ssh
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config

useradd ansibleadmin
#set password for ansibleadmin as 123
echo "123" | passwd --stdin ansibleadmin

sudo yum install -y git
sudo git clone https://github.com/pigergast/COSC2767-RMIT-Store.git /var/www/html/