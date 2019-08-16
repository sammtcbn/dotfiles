#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.8.16

PROJECTNAME=repo_sam

while getopts "c" opt; do
    case $opt in
    c)
       COMPRESS=1
       ;;
    esac
done

function init_ubtroot_path() {
    UBTROOT_SETTING=~/.config/.ubtroot
    if [ -f ${UBTROOT_SETTING} ]; then
        UBTROOT=`cat ${UBTROOT_SETTING}`
    else
        UBTROOT=~
    fi
    #echo "UBTROOT = ${UBTROOT}"
}

function do_compress() {
    destfile=${PROJECTNAME}-$(date '+%Y%m%d').tar.gz
    cd $TOPDIR/.. || exit 1
    rm -f $destfile || exit 1
    tar zcfv $destfile ${PROJECTNAME}
    ls -la $destfile
}

function git_src() {
    folder=$1
    url=$2
    echo "${url} ..."
    if [ ! -d "${TOPDIR}/${folder}" ]; then
        cd $TOPDIR || exit 1
        git clone ${url} || exit 1
    else
        cd ${TOPDIR}/${folder} || exit 1
        git pull || exit 1
    fi

    cd ${TOPDIR}/${folder} || exit 1
    git config user.name "sammtcbn" || exit 1
    git config user.email "sammtcbn@gmail.com" || exit 1
}

init_ubtroot_path
TOPDIR=${UBTROOT}/${PROJECTNAME}
mkdir -p ${TOPDIR}

git_src dotfiles      https://sammtcbn@github.com/sammtcbn/dotfiles.git
git_src spe           https://sammtcbn@github.com/sammtcbn/spe.git
git_src fpjson        https://sammtcbn@github.com/sammtcbn/fpjson.git
git_src libreadini    https://sammtcbn@github.com/sammtcbn/libreadini.git
git_src logshow       https://sammtcbn@github.com/sammtcbn/logshow.git
git_src sccu          https://sammtcbn@github.com/sammtcbn/sccu.git
git_src advutil       https://sammtcbn@github.com/sammtcbn/advutil.git
git_src ingrautil     https://sammtcbn@github.com/sammtcbn/ingrautil.git
git_src ediutil       https://sammtcbn@github.com/sammtcbn/ediutil.git
git_src mqtt-show-msg https://sammtcbn@github.com/sammtcbn/mqtt-show-msg.git
git_src ssn           https://sammtcbn@github.com/sammtcbn/ssn.git
git_src advdotfiles   https://sammtcbn@github.com/sammtcbn/advdotfiles.git

if [ "${COMPRESS}" == 1 ]; then
    do_compress
fi
