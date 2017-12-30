#!/bin/bash

set -euxo pipefail

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
cd "$CWD"

export DEBIAN_FRONTEND=noninteractive

apt-get update

# for docker env only
apt-get install -y --no-install-recommends apt-utils software-properties-common apt-transport-https ca-certificates 

# required for zsh
apt-get install -y --no-install-recommends zsh curl wget git

# oh-my-zsh
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /tmp/install-oh-my-zsh.sh &&
    zsh /tmp/install-oh-my-zsh.sh --unattended && rm -vf /tmp/install-oh-my-zsh.sh
cp -v .zshrc "$HOME"/.zshrc
chsh -s "$(which zsh)"

# jq
curl -sL https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o jq
chmod +x jq
mv jq /usr/bin

# fzf
echo "install fzf later"

# developer toolchain
apt-get install -y --no-install-recommends vim zip unzip p7zip-full iftop vnstat fail2ban lynx ntpdate tmux htop gcc g++ build-essential

# python 3
apt-get install -y --no-install-recommends python3-dev python3-pip python3-setuptools
python3.8 -m pip install -U pip setuptools
ln -sf /usr/bin/python3.8 /usr/bin/python

# go
GO_PATH=/go
GO_VERSION=1.12.6
OS=linux
ARCH=amd64
mkdir -p "$GO_PATH"
wget -q -O go.tgz "https://dl.google.com/go/go${GO_VERSION}.${OS}-${ARCH}.tar.gz" && echo "dbcf71a3c1ea53b8d54ef1b48c85a39a6c9a935d01fc8291ff2b92028e59913c *go.tgz" | sha256sum -c - 
tar -C /usr/local -xzf go.tgz && rm -f go.tgz

# start
zsh

# manual update system: upgrade
