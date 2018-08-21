#!/bin/sh
set -e
# Create DB if it doesn't exits
mysql -u root -p$ZING_DB_ROOT_PASSWORD -h zing.database -e "CREATE DATABASE IF NOT EXISTS zing CHARACTER SET utf8 COLLATE utf8_general_ci;"

# Start worker
zing rqworker &

# Init db
zing migrate
zing initdb

# Create default data
zing update_stores

# Build assets and i18n
zing build_assets
zing assets build
zing compilejsi18n

exec "$@"
