# ------------------------------------------------------------------------------
# Pull base image
FROM ubuntu:focal

# ------------------------------------------------------------------------------
# Set environment variables
ENV DEBIAN_FRONTEND noninteractive
ENV LANG C
ENV NODEPKGURL https://nodejs.org/dist/v18.14.0/node-v18.14.0-linux-x64.tar.xz
ENV GOLANGURL https://go.dev/dl/go1.20.linux-amd64.tar.gz
ENV PASSWD admin
ENV C9PORT 80
ENV RCLONE_CONFIG_PASS rclone
ENV SHURL https://github.com/c21xdx/free/blob/master/cloud9.sh

# ------------------------------------------------------------------------------
# Add config folder
COPY c9conf /etc/c9conf

# ------------------------------------------------------------------------------
# Install base and clean up
RUN apt-get update && apt-get install -y --no-install-recommends \
	build-essential g++ locales curl git ca-certificates supervisor sudo vim wget openssh-client net-tools cron unzip python2.7-minimal && \
	sed -e 's/# en_US.UTF-8/en_US.UTF-8/' -i /etc/locale.gen && locale-gen && \
	apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Install Cloud9 and clean up
RUN curl -s ${NODEPKGURL} -o /tmp/node.tar.xz && \
	tar xf /tmp/node.tar.xz -C /opt/ && \
	rm /tmp/node.tar.xz && \
	mv /opt/node-* /opt/node && \
	ln -s /opt/node/bin/node /usr/bin/node && \
	ln -s /opt/node/bin/node /usr/bin/nodejs && \
	ln -s /opt/node/bin/npm /usr/bin/npm && \
	git clone https://github.com/c9/core.git /c9 && \
	cd /c9 && ./scripts/install-sdk.sh && \
	rm -rf /opt/node /usr/bin/node /usr/bin/nodejs /usr/bin/npm && \
	rm -rf /root/.c9/libevent-* /root/.c9/ncurses-* /root/.c9/tmux-* && \
	rm -rf /c9/.git /root/.c9/tmp /root/.npm /root/.node-gyp /tmp/* && \
	PATH="$PATH:/root/.c9/node/bin" npm install -g c9 && \
	mkdir /c9ws

# ------------------------------------------------------------------------------
# Install rclone golang and others
RUN curl https://rclone.org/install.sh | sudo bash && \
    chmod +x /etc/c9conf/c9run.sh && \
    curl -s ${GOLANGURLL} -o /tmp/golang.tar.gz && \
    rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/golang.tar.gz && rm /tmp/golang.tar.gz && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/* /tmp/*

# ------------------------------------------------------------------------------
# Define default command
ENTRYPOINT ["/etc/c9conf/c9run.sh"]
