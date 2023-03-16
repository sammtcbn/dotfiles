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

echo ========================================

echo df -h
remote_exec df -h

echo ========================================

echo fdisk -l
remote_root_exec fdisk -l

echo ========================================

echo parted -l
remote_root_exec parted -l

echo ========================================

echo free -m
remote_exec free -m

echo ========================================

echo cat /proc/meminfo
remote_exec cat /proc/meminfo

echo ========================================

echo top -n 1 -b
remote_exec top -n 1 -b

echo ========================================

echo uptime
remote_exec uptime

echo ========================================

echo done
