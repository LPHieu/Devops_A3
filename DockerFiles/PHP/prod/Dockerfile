FROM php:8.3-apache
ENV DBHost "172.31.81.35"
ENV DBPort "8081"
WORKDIR /var/www/html
COPY . .
RUN docker-php-ext-install mysqli && docker-php-ext-enable mysqli

