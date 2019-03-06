#!/bin/bash
# Install teamviewer for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.3.6
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb || exit 1

dpkg --add-architecture i386 || exit 1

apt update || exit 1

dpkg -i teamviewer_amd64.deb

# install dependency
apt-get -y install -f || exit 1

# intall again
dpkg -i teamviewer_amd64.deb || exit 1

rm -f teamviewer_amd64.deb || exit 1

echo "done"
