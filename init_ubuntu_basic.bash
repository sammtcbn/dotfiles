#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.10.26

ME=$(basename $0)

ip=
id=
pw=

if [ ! -z "${1}" ]; then
    ip=${1}
    if [ ! -z "${2}" ]; then
        id=${2}
    else
        read -p "login id: " id
        if [ -z "${id}" ]; then
            id=$USER
            echo ${id}
        fi
    fi
    printf "login password: "
    read -s pw
    if [ -z "${pw}" ]; then
        printf "\n"
        exit 1
    fi
    printf "*\n"
fi

function cmd_exists ()
{
    if ! type $1> /dev/null 2>&1; then
        return 1
    else
        return 0
    fi
}

function cmd_exec ()
{
    if [ -z "${ip}" ]; then
        ${@}
    else
        if cmd_exists sshpass ; then
            sshpass -p ${pw} ssh -t -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${id}@${ip} "${@}"
        else
            ssh ${id}@${ip} "${@}"
        fi
    fi
}

cmd_exec sudo apt -y update
cmd_exec sudo apt -y install lsb-release openssh-server vim curl ncal samba
