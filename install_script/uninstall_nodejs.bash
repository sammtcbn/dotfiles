#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.12.28
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

apt -y purge --auto-remove nodejs
