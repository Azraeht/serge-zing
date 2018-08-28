#!/bin/sh
set -e

# SSH setup for VCS access (Git)
echo " - Setting up ssh"
cp -R /tmp/.ssh /root/.ssh
chmod 700 /root/.ssh
chmod 644 /root/.ssh/id_rsa.pub
chmod 600 /root/.ssh/id_rsa
ssh-keyscan -t rsa $GIT_SERVER_DOMAIN >> ~/.ssh/known_hosts

# Create DB if it doesn't exits
echo " - Checking DB state"
mysql -u root -p$ZING_DB_ROOT_PASSWORD -h db -e "CREATE DATABASE IF NOT EXISTS zing CHARACTER SET utf8 COLLATE utf8_general_ci;"

# Init db
echo " - Restore Revision"
zing revision --restore || true
echo " - Init DB"
zing migrate
zing initdb

# Restore revision in Redis
echo " - Restore Revision"
zing revision --restore || true

# # Create default data
echo " - Update Stores"
zing update_stores

# # Build assets and i18n
echo " - Build Assets"
zing build_assets
zing assets build
zing compilejsi18n

# Start worker
echo " - Start worker"
zing rqworker &

exec "$@"
