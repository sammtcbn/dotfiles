#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.10.12

PROJECTNAME=repo_sam

while getopts "c" opt; do
    case $opt in
    c)
       COMPRESS=1
       ;;
    esac
done

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
}

TOPDIR=~/${PROJECTNAME}
mkdir -p ${TOPDIR}

git_src dotfiles      https://github.com/sammtcbn/dotfiles.git
git_src spe           https://github.com/sammtcbn/spe.git
git_src fpjson        https://github.com/sammtcbn/fpjson.git
git_src libreadini    https://github.com/sammtcbn/libreadini.git
git_src logshow       https://github.com/sammtcbn/logshow.git
git_src sccu          https://github.com/sammtcbn/sccu.git
git_src advutil       https://github.com/sammtcbn/advutil.git

if [ "${COMPRESS}" == 1 ]; then
    do_compress
fi
