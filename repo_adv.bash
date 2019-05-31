#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.5.31

ADV_GITLAB_ID=
ADV_GITLAB_PW=
ADV_GITLAB_USE_HTTP=y
ADV_GITLAB_USE_SSH=n

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

function init_ubtroot_path() {
    UBTROOT_SETTING=~/.ubtroot
    if [ -f ${UBTROOT_SETTING} ]; then
        UBTROOT=`cat ${UBTROOT_SETTING}`
    else
        UBTROOT=~
    fi
    #echo "UBTROOT = ${UBTROOT}"
}

function load_advgitlab_account() {
    GITLABAUTHFILE=~/.advgitlab
    if [ -f ${GITLABAUTHFILE} ]; then
        ADV_GITLAB_ID=`cat ${GITLABAUTHFILE} | grep ID= | awk 'BEGIN {FS="="}; {print $2}'`
        ADV_GITLAB_PW=`cat ${GITLABAUTHFILE} | grep PW= | awk 'BEGIN {FS="="}; {print $2}'`
        #echo "ADV_GITLAB_ID = ${ADV_GITLAB_ID}"
        #echo "ADV_GITLAB_PW = ${ADV_GITLAB_PW}"
    fi
}

function load_advsvn_account() {
    SVNAUTHFILE=~/.advsvn
    if [ -f ${SVNAUTHFILE} ]; then
        ADV_SVN_ID=`cat ${SVNAUTHFILE} | grep ID= | awk 'BEGIN {FS="="}; {print $2}'`
        ADV_SVN_PW=`cat ${SVNAUTHFILE} | grep PW= | awk 'BEGIN {FS="="}; {print $2}'`
        #echo "ADV_SVN_ID = ${ADV_SVN_ID}"
        #echo "ADV_SVN_PW = ${ADV_SVN_PW}"
    fi
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
        if [ "${ADV_GITLAB_USE_HTTP}" == "y" ]; then
            if [ -n "$ADV_GITLAB_ID" ] && [ -n "$ADV_GITLAB_PW" ]; then
                git clone http://${ADV_GITLAB_ID}:${ADV_GITLAB_PW}@advgitlab.eastasia.cloudapp.azure.com/${url} || exit 1
            elif [ -n "$ADV_GITLAB_ID" ]; then
                git clone http://${ADV_GITLAB_ID}@advgitlab.eastasia.cloudapp.azure.com/${url} || exit 1
            else
                git clone http://advgitlab.eastasia.cloudapp.azure.com/${url} || exit 1
            fi
        elif [ "${ADV_GITLAB_USE_SSH}" == "y" ]; then
            git clone git@advgitlab.eastasia.cloudapp.azure.com:${url} || exit 1
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
        if [ -n "$ADV_SVN_ID" ] && [ -n "$ADV_SVN_PW" ]; then
            svn co --username $ADV_SVN_ID https://172.20.2.44/${url} --password $ADV_SVN_PW || exit 1
        elif [ -n "$ADV_SVN_ID" ]; then
            svn co --username $ADV_SVN_ID https://172.20.2.44/${url} || exit 1
        else
            svn co https://172.20.2.44/${url} || exit 1
        fi
    else
       cd ${TOPDIR}/${folder} || exit 1
       svn up || exit 1
    fi
}

init_ubtroot_path
TOPDIR=${UBTROOT}/${PROJECTNAME}
mkdir -p ${TOPDIR}

load_advgitlab_account
load_advsvn_account

function g_EI-Connect() {
  advgitlab_src EI-Platform        EI-Connect/EI-Platform.git
  advgitlab_src EI-Lib             EI-Connect/EI-Lib.git
  advgitlab_src EI-Connect         EI-Connect/EI-Connect.git
  advgitlab_src EI-Predefine       EI-Connect/EI-Predefine.git
  advgitlab_src EI-Connect-Python  EI-Connect/EI-Connect-Python.git
  advgitlab_src EI-Connect-Node.js EI-Connect/EI-Connect-Node.js.git
  advgitlab_src EI-Connect-CSharp  EI-Connect/EI-Connect-CSharp.git
  advgitlab_src EI-Manifests       EI-Connect/EI-Manifests.git
  advgitlab_src EI-MQTTConnector   EI-Connect/EI-MQTTConnector.git
  advgitlab_src EI-WISECore        EI-Connect/EI-WISECore.git
  advgitlab_src EI-Connect-JNI     EI-Connect/EI-Connect-JNI.git
}

git_src APIGateway         https://github.com/ADVANTECH-Corp/APIGateway.git
git_src WiseSnail          https://github.com/ADVANTECH-Corp/WiseSnail.git
advgitlab_src device-snmp-nms-node.js EdgeSense/device-snmp-nms-node.js.git
advgitlab_src device-opcua-client-node.js EdgeSense/device-opcua-client-node.js.git
advgitlab_src device-poc_link-mgt-node.js EdgeSense/device-poc_link-mgt-node.js.git
advgitlab_src poc_battery-app-wpf EdgeSense/poc_battery-app-wpf.git
advgitlab_src EdgeX-WiseAgent-Device  EdgeSense/EdgeX-WiseAgent-Device.git
advgitlab_src uartmgr            EdgeSense/uartmgr.git
advgitlab_src ReyaxSol           EdgeSense/ReyaxSol.git
advgitlab_src ePack              EdgeSense/ePack.git
advgitlab_src MQTTBroker         EdgeSense/MQTTBroker.git
advgitlab_src WAPI               EdgeSense/WAPI.git
advgitlab_src Service-SDK        EdgeSense/Service-SDK.git
advgitlab_src TowerLight-Sensor  EdgeSense/TowerLight-Sensor.git
advgitlab_src Modbus-Slave       EdgeSense/Modbus-Slave.git
advgitlab_src AgentLite-Node.js  EdgeSense/AgentLite-Node.js.git
advgitlab_src Alarm_msg_service  EdgeSense/Alarm_msg_service.git
advgitlab_src Mirai              EdgeSense/Mirai.git
advgitlab_src advlog-node.js     EdgeSense-Open/advlog-node.js.git
advgitlab_src RMM-EI-Agent           EI-PaaS-RMM/RMM-EI-Agent.git
advgitlab_src RMM-EI-Agent_Installer EI-PaaS-RMM/RMM-EI-Agent_Installer.git
advgitlab_src EdgeX-Plugin       EI-PaaS-Plugin/EdgeX-Plugin.git
advgitlab_src LocalProvision     EI-PaaS-Plugin/LocalProvision.git
advgitlab_src WISE-3610_downlink WISE-IoT/WISE-3610_downlink.git
advgitlab_src AdvTools           WISE-IoT/AdvTools.git
advgitlab_src EI-Connect         EI-Connect/EI-Connect.git
advgitlab_src EI-Platform        EI-Connect/EI-Platform.git

g_EI-Connect

advsvn_src CAgentIoT       svn/SUSIAccess/SA3.1/trunk/Agent/CAgentIoT

if [ "${COMPRESS}" == 1 ]; then
    do_compress
fi
