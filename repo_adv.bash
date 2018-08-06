#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.8.6

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

TOPDIR=~/repo_adv
mkdir -p ${TOPDIR}

git_src APIGateway         https://github.com/ADVANTECH-Corp/APIGateway.git

git_src WiseSnail          https://github.com/ADVANTECH-Corp/WiseSnail.git

git_src ePack              http://advgitlab.eastasia.cloudapp.azure.com/EdgeSense/ePack.git

git_src MQTTBroker         http://advgitlab.eastasia.cloudapp.azure.com/EdgeSense/MQTTBroker.git

git_src WISE-3610_downlink http://advgitlab.eastasia.cloudapp.azure.com/WISE-IoT/WISE-3610_downlink.git

git_src WAPI               http://advgitlab.eastasia.cloudapp.azure.com/EdgeSense/WAPI.git

git_src EI-Connect         http://advgitlab.eastasia.cloudapp.azure.com/EI-Connect/EI-Connect.git

git_src RMM-EI-Agent       http://advgitlab.eastasia.cloudapp.azure.com/EI-PaaS-RMM/RMM-EI-Agent.git
