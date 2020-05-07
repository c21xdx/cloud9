#!/bin/sh

sed -i "s/password/$PASSWD/" /etc/c9conf/supervisord.conf
sed -i "s/c9port/$C9PORT/" /etc/c9conf/supervisord.conf
wget $SHURL -O /etc/c9conf/c9.sh
sh /etc/c9conf/c9.sh
supervisord -c /etc/c9conf/supervisord.conf
