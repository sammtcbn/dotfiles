#!/bin/bash
# Install anydesk for Ubuntu
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2020.2.10
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

apt update || exit 1

wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -

echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list

apt update || exit 1

apt install anydesk || exit 1
