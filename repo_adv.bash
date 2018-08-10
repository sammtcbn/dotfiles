#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.8.10

ADV_GITLAB_ID=
ADV_GITLAB_PW=

ADV_SVN_ID=
ADV_SVN_PW=

PROJECTNAME=repo_adv

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
        git clone $url || exit 1
    else
        cd ${TOPDIR}/${folder} || exit 1
        git pull || exit 1
    fi
}

function advgitlab_src() {
    folder=$1
    url=$2
    echo "${url} ..."
    if [ ! -d "${TOPDIR}/${folder}" ]; then
        cd $TOPDIR || exit 1
        if [ -n "$ADV_GITLAB_ID" ] && [ -n "$ADV_GITLAB_PW" ]; then
            git clone http://${ADV_GITLAB_ID}:${ADV_GITLAB_PW}@advgitlab.eastasia.cloudapp.azure.com/${url} || exit 1
        else
            git clone http://advgitlab.eastasia.cloudapp.azure.com/${url} || exit 1
        fi
    else
        cd ${TOPDIR}/${folder} || exit 1
        git pull || exit 1
    fi
}


function advsvn_src() {
    folder=$1
    url=$2
    echo "${url} ..."
    if [ ! -d "${TOPDIR}/${folder}" ]; then
        cd $TOPDIR || exit 1
        svn co --username $ADV_SVN_ID https://172.20.2.44/${url} --password $ADV_SVN_PW || exit 1
    else
       cd ${TOPDIR}/${folder} || exit 1
       svn up || exit 1
    fi
}

TOPDIR=~/${PROJECTNAME}
mkdir -p ${TOPDIR}

git_src APIGateway         https://github.com/ADVANTECH-Corp/APIGateway.git
git_src WiseSnail          https://github.com/ADVANTECH-Corp/WiseSnail.git

advgitlab_src uartmgr            EdgeSense/uartmgr.git
advgitlab_src ReyaxSol           EdgeSense/ReyaxSol.git
advgitlab_src ePack              EdgeSense/ePack.git
advgitlab_src MQTTBroker         EdgeSense/MQTTBroker.git
advgitlab_src RMM-EI-Agent       EI-PaaS-RMM/RMM-EI-Agent.git
advgitlab_src WAPI               EdgeSense/WAPI.git
advgitlab_src WISE-3610_downlink WISE-IoT/WISE-3610_downlink.git

git_src EI-Connect         http://advgitlab.eastasia.cloudapp.azure.com/EI-Connect/EI-Connect.git

advsvn_src CAgentIoT       svn/SUSIAccess/SA3.1/trunk/Agent/CAgentIoT

if [ "${COMPRESS}" == 1 ]; then
    do_compress
fi
