#!/bin/bash

export LC_ALL=C
sudo apt update -y

# buat swapfile 512 MB

echo "[CREATE] Swap File 512 MB"

sudo /bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=512       # swap 512 MB
sudo /sbin/mkswap /var/swap.1                                  # if=input_file, of=output_file
sudo chmod 600 /var/swap.1                                     # bs=block_size
sudo /sbin/swapon /var/swap.1

# docker

echo "[INSTALL] Docker"

sudo apt install -y docker.io
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

# docker compose

echo "[INSTALL] docker-compose"

sudo apt install -y docker-compose
sudo systemctl restart docker
sudo docker-compose up -d

# copy config.php to container moodle, readreplica

# sleep 200    # replace config.php setelah menunggu instalasi moodle selesai
# echo "[COPY] config.php -> Docker container moodle"

# sudo docker cp config.php moodle:/bitnami/moodle/config.php
# sudo docker restart moodle

# docker restart after copy 
