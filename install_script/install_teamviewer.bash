#!/bin/bash
# Install teamviewer for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.3.6
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

apt update || exit 1

wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb || exit 1

function method_dpkg() {
  dpkg --add-architecture i386 || exit 1

  dpkg -i teamviewer_amd64.deb

  # install dependency
  apt -y install -f || exit 1

  # intall again
  dpkg -i teamviewer_amd64.deb || exit 1
}

function method_gdebi() {
  apt -y install gdebi-core
  gdebi -n teamviewer_amd64.deb
}

function check_service_status() {
  systemctl status teamviewerd
}

#method_dpkg
method_gdebi

rm -f teamviewer_amd64.deb || exit 1

systemctl enable teamviewerd || exit 1

