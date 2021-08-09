#!/bin/bash

export LC_ALL=C
sudo apt update -y

# install additional software
# sudo apt install -y apache2 mysql-client mysql-server php libapache2-mod-php
sudo apt install -y mysql-client

# install additional software
# sudo apt install -y graphviz aspell ghostscript clamav php-pspell php-curl php-gd php-intl php-mysql php-xml php-xmlrpc php-ldap php-zip php-soap php-mbstring

# install python-minimal
# sudo apt install -y python-minimal

# install Make
# sudo apt install make -y

# sudo apt install docker.io
# install docker-engine
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# sudo apt update -y
# sudo apt install -y docker-ce
sudo apt install -y docker.io

echo "Docker installed..."

sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

echo "# install docker-compose"

sudo apt install -y docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo systemctl restart docker

echo "docker-compose installed..."

# mysql -h rdsmoodletest.chngnw3p2ako.us-east-1.rds.amazonaws.com -P 3306 -u user -puser123! < file-moodle-db.sql

sudo docker-compose up