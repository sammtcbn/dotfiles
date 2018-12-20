#!/bin/bash
# Install webmin for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.12.21
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

webmin_repo="deb http://download.webmin.com/download/repository sarge contrib"
system_source_list=/etc/apt/sources.list

if grep -q "$webmin_repo" "$system_source_list"; then
    echo "webmin repo exist in $system_source_list"
else
    echo "${webmin_repo}" | tee --append $system_source_list > /dev/null || exit 1
fi

wget http://www.webmin.com/jcameron-key.asc || exit 1
apt-key add jcameron-key.asc || exit 1
rm -f jcameron-key.asc || exit 1

apt update
apt -y install webmin
