#!/bin/bash

export LC_ALL=C
sudo apt update -y

sudo apt install -y docker.io

echo "[INSTALLED] Docker."

sudo usermod -aG docker ubuntu
sudo systemctl enable docker
sudo systemctl start docker

echo "# install docker-compose"

sudo apt install -y docker-compose

sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

sudo systemctl restart docker

echo "[INSTALLED] docker-compose."

# sudo docker-compose up -d

# echo "RUN-SCRIPT.SH completed"

# curl -Ls https://raw.githubusercontent.com/newrelic/newrelic-cli/master/scripts/install.sh | bash && sudo NEW_RELIC_API_KEY=NRAK-4VBWLQC5OBWOSUF6ZZ162WXD3BZ NEW_RELIC_ACCOUNT_ID=3263477 /usr/local/bin/newrelic install