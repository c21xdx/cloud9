#!/bin/sh

sed -i "s/password/$PASSWD/" /etc/c9conf/supervisord.conf
sed -i "s/c9port/$C9PORT/" /etc/supervisord.conf
wget $SHURL -O /etc/c9conf/rclone.sh
sh /etc/c9conf/rclone.sh
supervisord -c /etc/c9conf/supervisord.conf
