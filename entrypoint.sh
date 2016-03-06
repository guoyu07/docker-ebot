#!/bin/bash
ebot_dir=$1
ebot_ip=""
MYSQL_USER=""
MYSQL_PASS=""
MYSQL_DB=""

sed -i "s/MYSQL_USER = \"ebotv3\"/MYSQL_USER = \"$MYSQL_USER\"/g" $ebot_dir/config/config.ini
sed -i "s/MYSQL_PASS = \"ebotv3\"/MYSQL_PASS = \"$MYSQL_PASS\"/g" $ebot_dir/config/config.ini
sed -i "s/MYSQL_BASE = \"ebotv3\"/MYSQL_BASE = \"$MYSQL_DB\"/g" $ebot_dir/config/config.ini
sed -i "s/BOT_IP = \"127.0.0.1\"/BOT_IP = \"$ebotip\"/g" $ebot_dir/config/config.ini

exec php $1/bootstrap.php
