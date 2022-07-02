#!/bin/sh

localectl set-locale LC_TIME="id_ID.UTF-8"

echo "[INSTALL] Docker dan Docker Compose"

sudo apt update -y
sudo apt install -y docker.io docker-compose make sysstat mysql-client
sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker
sudo docker-compose up -d

sleep 200

# copy config.php berisi konfig read-replica ke docker moodle
# echo "[COPY] config.php -> Docker container moodle"

sudo docker cp config.php moodle:/var/www/html/config.php












# docker exec -it moodle sh


# # ami linux 2, yum

# export LC_ALL=C
# sudo yum update -y

# # echo "[INSTALL] Docker dan Docker Compose"

# sudo yum install docker mariadb -y
# sudo service docker start
# sudo usermod -aG docker ec2-user

# echo PUBLIC_DNS=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname) > .env

# sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
# sudo chmod +x /usr/local/bin/docker-compose
# docker-compose version
# sudo docker-compose up -d
