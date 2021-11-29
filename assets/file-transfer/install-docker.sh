#!/bin/sh

export LC_ALL=C
sudo apt update -y

# print ec2 public dns ke dalam env untuk deployment docker erseco/alpinemoodles

echo PUBLIC_DNS=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname) > .env

# docker

echo "[INSTALL] Docker dan Docker Compose"

sudo apt install -y docker.io docker-compose
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker
sudo docker-compose up -d

sleep 200                               # detik, proses instalasi hingga  moodle selesai

# copy config.php berisi konfig read-replica ke docker moodle
echo "[COPY] config.php -> Docker container moodle"

sudo docker cp config.php moodle:/var/www/html/config.php
# sudo docker restart moodle

