#!/bin/bash
# Install Node-Red for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.11.7
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

npm install -g --unsafe-perm node-red node-red-admin node-red-dashboard
ufw allow 1880
