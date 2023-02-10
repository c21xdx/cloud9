#!/bin/sh

export PATH=$PATH:/usr/local/go/bin

NODE_ENV="production"
export PATH="${PATH}:/root/.c9/node/bin"

export FLYCTL_INSTALL="/root/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# 密码及端口修改
sed -i "s/password/$PASSWD/" /etc/c9conf/supervisord.conf
sed -i "s/c9port/$C9PORT/" /etc/c9conf/supervisord.conf

# 设置crontab
env >> /etc/default/locale
touch /var/spool/cron/crontabs/root
echo "*/10 * * * * /bin/sh /c9ws/rclone/sync.sh >/dev/null 2>&1" >>/var/spool/cron/crontabs/root
chmod 600 /var/spool/cron/crontabs/root
service cron restart

# 其它的...
# wget $SHURL -O /etc/c9conf/others.sh
# sh /etc/c9conf/others.sh

supervisord -c /etc/c9conf/supervisord.conf
