#!/bin/bash
# Install Node-Red for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.12.21
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

apt update
apt-get -y install npm
npm install -g --unsafe-perm node-red node-red-admin
ufw allow 1880
