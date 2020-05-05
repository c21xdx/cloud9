#!/bin/sh

apt-get update
# 安装rclone
curl https://rclone.org/install.sh | sudo bash
# 安装 cf cli
curl -L "https://packages.cloudfoundry.org/stable?release=linux64-binary&source=github" | tar -zx
mv cf /usr/local/bin
sudo curl -o /usr/share/bash-completion/completions/cf https://raw.githubusercontent.com/cloudfoundry/cli/master/ci/installers/completion/cf
# 安装 ibmcloud cli
curl -sL https://ibm.biz/idt-installer | bash
# 安装OKTETO CLI
curl https://get.okteto.com -sSfL | sh
# 安装flyctl
curl -L https://getfly.fly.dev/install.sh | sh
