#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.12.27
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

#apt -y remove nodejs npm
apt -y purge nodejs npm
