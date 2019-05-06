#!/bin/bash
# Install webmin for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.5.6
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


# uninstall steps:
#   - run "sudo /etc/webmin/uninstall.bash"
#   - del key
#       run "sudo apt-key list" to find webmin key , ex:
#         pub   1024D/11F63C51 2002-02-28
#         uid                  Jamie Cameron <jcameron@webmin.com>
#         sub   1024g/1B24BE83 2002-02-28
#       run "sudo apt-key del 11F63C51
#   - remove apt source lists
#       edit /etc/apt/sources.list and remove webmin related
