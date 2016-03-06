#!/bin/bash
EBOT_DIR=$1
EBOT_IP=""
MYSQL_USER=""
MYSQL_PASS=""
MYSQL_DB=""

sed -i "s/MYSQL_USER = \"ebotv3\"/MYSQL_USER = \"$MYSQL_USER\"/g" $EBOT_DIR/config/config.ini
sed -i "s/MYSQL_PASS = \"ebotv3\"/MYSQL_PASS = \"$MYSQL_PASS\"/g" $EBOT_DIR/config/config.ini
sed -i "s/MYSQL_BASE = \"ebotv3\"/MYSQL_BASE = \"$MYSQL_DB\"/g" $EBOT_DIR/config/config.ini
sed -i "s/BOT_IP = \"127.0.0.1\"/BOT_IP = \"$EBOT_IP\"/g" $EBOT_DIR/config/config.ini

exec php $EBOT_DIR/bootstrap.php
