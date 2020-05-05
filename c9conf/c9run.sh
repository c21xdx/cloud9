#!/bin/sh

sed -i "s/password/$PASSWD/" /etc/c9conf/supervisord.conf
sed -i "s/ide_domain/$DOMAIN/" /etc/c9conf/Caddyfile
sed -i "s/ide_domain_port/$DOMAIN_PORT/" /etc/c9conf/Caddyfile
wget -o /etc/c9conf/new.sh https://raw.githubusercontent.com/c21xdx/cloud9/new/c9conf/new.sh?token=ABL7YBKOEA5CESQ5BUZGE226WFP4U
chmod +x 
supervisord -c /etc/c9conf/supervisord.conf
