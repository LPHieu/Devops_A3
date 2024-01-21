# RMIT University Vietnam
# Course: COSC2767 Systems Deployment and Operations
# Semester: 2023C
# Assessment: Assignment 3
# Author: Group 3
# Created  date: 02/01/2023
# Last modified: 20/01/2023
# Acknowledgement: None

FROM php:8.3-apache
ENV DBHost "44.218.193.34"
ENV DBPort "8081"
WORKDIR /var/www/html
COPY . .
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

