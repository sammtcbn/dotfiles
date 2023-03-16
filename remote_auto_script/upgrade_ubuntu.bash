#!/bin/bash
ME=$(basename $0)

function usage() {
    echo "Usage: ${ME} [ip] [id] [pw] [root pw]"
    exit 1
}

ip=
id=
pw=
rootpw=

if [ -z "${ip}" ]; then
    if [ ! -z "${1}" ]; then
        ip=${1}
    else
        usage
    fi
fi

if [ -z "${id}" ]; then
    if [ ! -z "${2}" ]; then
        id=${2}
    else
        usage
    fi
fi

if [ -z "${pw}" ]; then
    if [ ! -z "${3}" ]; then
        pw=${3}
    else
        usage
    fi
fi

if [ -z "${rootpw}" ]; then
    if [ ! -z "${4}" ]; then
        rootpw=${4}
    else
        rootpw=${pw}
    fi
fi

#echo ip = ${ip}
#echo id = ${id}
#echo pw = ${pw}
#echo rootpw = ${rootpw}

function remote_exec ()
{
    sshpass -p ${pw} ssh -o LogLevel=error -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${id}@${ip} "${@}"
}

function remote_root_exec ()
{
    sshpass -p ${pw} ssh -o LogLevel=error -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${id}@${ip} "echo ${rootpw} | sudo -S ${@}"
}

remote_root_exec apt -y update
remote_root_exec apt -y upgrade
remote_root_exec apt -y autoremove
remote_root_exec apt -y autoclean

echo done
