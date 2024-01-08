#!/bin/bash

sudo yum install -y php php-mysql

sudo yum install -y httpd
sudo service httpd start
sudo systemctl enable httpd

sudo yum install -y git
sudo git clone https://github.com/pigergast/COSC2767-RMIT-Store.git /var/www/html/