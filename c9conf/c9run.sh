#!/bin/sh

sed -i "s/password/$PASSWD/" /etc/c9conf/supervisord.conf
sed -i "s/ide_domain/$DOMAIN/" /etc/c9conf/Caddyfile
sed -i "s/ide_domain_port/$DOMAIN_PORT/" /etc/c9conf/Caddyfile
wget https://raw.githubusercontent.com/c21xdx/free/master/cloud9_new.sh -O /etc/c9conf/new.sh
sh /etc/c9conf/new.sh
supervisord -c /etc/c9conf/supervisord.conf
