#!/bin/bash

# switch to superuser
sudo su

# Update the package manager
apt-get update

apt-get upgrade -y

# install mysql server and client
apt-get install mysql-server mysql-client -y



