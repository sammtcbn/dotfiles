#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.8.13

function git_src() {
    folder=$1
    url=$2
    echo "${url} ..."
    if [ ! -d "${TOPDIR}/${folder}" ]; then
        cd $TOPDIR || exit 1
        git clone $url || exit 1
    else
        cd ${TOPDIR}/${folder} || exit 1
        git pull || exit 1
    fi
}

TOPDIR=~/repomisc
mkdir -p ${TOPDIR}

git_src samba         https://github.com/samba-team/samba.git
git_src libwebsockets https://github.com/warmcat/libwebsockets.git 
git_src opencv        https://github.com/opencv/opencv.git
git_src linux         https://github.com/torvalds/linux.git
git_src httpd         https://github.com/apache/httpd.git
git_src libmodbus     https://github.com/stephane/libmodbus.git
git_src smartmontools https://github.com/smartmontools/smartmontools.git
git_src wget          https://git.savannah.gnu.org/git/wget.git
