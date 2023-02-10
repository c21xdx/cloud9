#!/bin/sh

export PATH=$PATH:/usr/local/go/bin

NODE_ENV="production"
export PATH="${PATH}:/root/.c9/node/bin"

sed -i "s/password/$PASSWD/" /etc/c9conf/supervisord.conf
sed -i "s/c9port/$C9PORT/" /etc/c9conf/supervisord.conf

wget $SHURL -O /etc/c9conf/rclone.sh
sh /etc/c9conf/rclone.sh

supervisord -c /etc/c9conf/supervisord.conf
