#!/bin/bash

export LC_ALL=C
sudo apt update -y

sudo apt install -y docker.io

# echo "[INSTALLED] Docker"

sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

# echo "# install docker-compose"

sudo apt install -y docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo systemctl restart docker

# echo "docker-compose installed..."

sudo docker-compose up -d

# echo "RUN-SCRIPT.SH completed"