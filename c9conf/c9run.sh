#!/bin/sh

sed -i "s/password/$PASSWD/" /etc/c9conf/supervisord.conf
sed -i "s/ide_domain/$DOMAIN/" /etc/c9conf/Caddyfile
sed -i "s/ide_domain_port/$DOMAIN_PORT/" /etc/c9conf/Caddyfile
wget -o /etc/c9conf/new.sh https://raw.githubusercontent.com/c21xdx/free/master/cloud9.sh
chmod +x /etc/c9conf/new.sh
supervisord -c /etc/c9conf/supervisord.conf
