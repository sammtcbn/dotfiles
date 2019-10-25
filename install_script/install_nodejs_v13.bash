#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.10.26
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
apt update
apt -y install nodejs
apt -y install npm 
