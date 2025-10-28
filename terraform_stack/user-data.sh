#!/bin/bash
set -xe

apt-get update -y
apt-get install -y curl git netcat mysql-client

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

npm install -g pm2

cd /home/ubuntu
git clone https://${github_token}@github.com/abrarsyedd/minimalist-architecture.git

cd minimalist-architecture

cat<<EOF > .env
DB_HOST=${rds_endpoint}
DB_USER=admin
DB_PASSWORD=admin12345
DB_NAME=minimalist_architecture_db
PORT=3000
SESSION_SECRET=your_session_secret
EOF

echo "Waiting for RDS to accept connections..."
for i in {1..20}; do
  nc -zv ${rds_endpoint} 3306 && break
  echo "RDS not ready yet... retrying in 10s"
  sleep 10
done

if [ -f "./database/schema.sql" ]; then
  echo "Importing schema into RDS..."
  mysql -h ${rds_endpoint} -u admin -padmin12345 minimalist_architecture_db < ./database/schema.sql
else
  echo "./database/schema.sql not found, skipping import."
fi

npm install
pm2 start server.js --name minimalist-architecture
pm2 startup systemd
pm2 save