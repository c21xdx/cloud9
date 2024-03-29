FROM ubuntu:bionic

ENV DEBIAN_FRONTEND noninteractive
ENV LANG C
ENV NODEPKGURL https://nodejs.org/dist/v18.14.0/node-v18.14.0-linux-x64.tar.xz
ENV PASSWD admin
ENV C9PORT 80
ENV SHURL https://raw.githubusercontent.com/c21xdx/free/master/cloud9.sh

COPY c9conf /etc/c9conf

RUN apt-get update && apt-get install -y --no-install-recommends \
build-essential g++ locales curl git ca-certificates supervisor sudo vim wget openssh-client net-tools cron unzip && \
sed -e 's/# en_US.UTF-8/en_US.UTF-8/' -i /etc/locale.gen && locale-gen && \
curl -s $NODEPKGURL -o /tmp/node.tar.xz && \
tar xf /tmp/node.tar.xz -C /opt/ && \
rm /tmp/node.tar.xz && \
mv /opt/node-* /opt/node && \
ln -s /opt/node/bin/node /usr/bin/node && \
ln -s /opt/node/bin/node /usr/bin/nodejs && \
ln -s /opt/node/bin/npm /usr/bin/npm && \
git clone https://github.com/c9/core.git /c9 && cd /c9 && \
./scripts/install-sdk.sh && \
rm -rf /opt/node /usr/bin/{node,nodejs,npm} && \
rm -rf /root/.c9/{libevent-*,ncurses-*,tmux-*} && \
rm -rf /c9/.git /root/.c9/tmp /root/.npm /root/.node-gyp && \
rm -rf /tmp/* && mkdir /c9ws && \
chmod +x /etc/c9conf/c9run.sh && \
apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

ENTRYPOINT ["/etc/c9conf/c9run.sh"]
