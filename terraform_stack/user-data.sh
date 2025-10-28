#!/bin/bash
set -xe

apt-get update -y
apt-get install -y curl git netcat mysql-client

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

npm install -g pm2

cd /home/ubuntu
git clone https://${GIT_TOKEN}@github.com/your-repo.git