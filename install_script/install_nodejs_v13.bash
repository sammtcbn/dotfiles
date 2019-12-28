#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.12.28
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

if ! [ -x "$(command -v curl)" ]; then
    echo 'Error: curl is not installed' >&2
    exit 1
fi

curl -sL https://deb.nodesource.com/setup_13.x | sudo -E bash -
apt -y install nodejs

# npm is also installed
