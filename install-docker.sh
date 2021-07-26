#!/bin/bash

export LC_ALL=C
sudo apt-get update -y

# install python-minimal
sudo apt-get install python-minimal -y

# install Make
sudo apt-get install make -y

# install docker-engine
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -y
sudo apt-get install -y docker-ce

echo "Docker installed..."

sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

echo "# install docker-compose"

sudo curl -L https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
echo "docker-compose installed..."