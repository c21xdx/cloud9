#!/bin/sh

sed -i "s/password/$PASSWD/" /etc/c9conf/supervisord.conf
supervisord -c /etc/c9conf/supervisord.conf
