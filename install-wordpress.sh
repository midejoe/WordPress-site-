#!/bin/bash

# switch to superuser
sudo su

# Update the package manager
apt-get update

apt-get upgrade -y

#install the Apache web server and PHP
apt-get install apache2 -y

apt-get install php8.1 php8.1-curl php8.1-mysql php8.1-mbstring php8.1-dom php8.1-gd -y

apt-get install libapache2-mod-php7.0

#nstall MySQL client that we can use to test the remote connection with our database server
apt-get install mysql-client -y

#change the directory 
cd /var/www/html

#remove all the files inside that directory
 rm -rf *

#download and extract WordPress files in the directory.
wget https://wordpress.org/latest.tar.gz

tar -xzvf latest.tar.gz

#move WordPress files from the wordpress directory to the current directory
mv wordpress/* ./

#set the proper permissions on the directory
chown -R www-data:www-data /var/www/html



