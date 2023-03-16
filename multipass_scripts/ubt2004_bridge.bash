#!/bin/bash
vmname=ubt2004

function show_multipass_info()
{
  echo multipass networks
  multipass networks
  echo

  echo multipass list
  multipass list
  echo
}

function show_instance_info()
{
  echo multipass info ${vmname}
  multipass info ${vmname}
  echo
}

function wait_multipass_ready()
{
  while :
  do
    multipass list 2> /dev/null
    ret=$?
    if [ $ret -eq 0 ]; then
        return
    fi
    echo waiting ...
    sleep 1
  done
}

function init_bridge()
{
  bridge_interface=eno1
  read -p "bridge interface: [${bridge_interface}] " tmpbridge
  if [ ! -z "${tmpbridge}" ]; then
    bridge_interface=${tmpbridge}
  fi
  read -p "Are you sure you want to use ${bridge_interface} as bridge? [y/N] " ins
  if [ "${ins}" != "y" ] && [ "${ins}" != "Y" ]; then
    echo bye
    exit 1
  fi

  echo sudo apt install lxd network-manager -y
  sudo apt install lxd network-manager -y
  echo
}

function init_multipass()
{
  echo sudo snap install multipass --classic
  sudo snap install multipass --classic
  echo
}

init_bridge

init_multipass

wait_multipass_ready

echo multipass set local.driver=lxd
multipass set local.driver=lxd
echo

wait_multipass_ready

echo multipass launch --name ${vmname} "20.04" --network ${bridge_interface}
multipass launch --name ${vmname} "20.04" --network ${bridge_interface}
echo

wait_multipass_ready

show_multipass_info

show_instance_info

