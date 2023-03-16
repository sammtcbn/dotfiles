#!/bin/bash
vmname=ubt2004
loginpw=1234
bridge_interface=eno1

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

function vmname_setup()
{
  read -p "Instance name: [${vmname}] " tmpvmname
  if [ ! -z "${tmpvmname}" ]; then
    vmname=${tmpvmname}
  fi
  echo Instance Name will be ${vmname}
}

function show_all_network_interface()
{
  echo All network interface:
  ip -o link show | awk -F': ' '{print $2}'
  echo
}

function bridgename_setup()
{
  read -p "Bridge interface: [${bridge_interface}] " tmpbridge
  if [ ! -z "${tmpbridge}" ]; then
    bridge_interface=${tmpbridge}
  fi
  echo Bridge interface will be ${bridge_interface}
}

function confirm_install()
{
  while true
  do
    read -p "Are you sure you want to continue to install? [Y/n]" ins
    if [ -z "${ins}" ]; then
      ins=y
    fi
    if [ "${ins}" == "n" ] || [ "${ins}" == "N" ]; then
      exit 1
    fi
    if [ "${ins}" == "y" ] || [ "${ins}" == "Y" ]; then
      break;
    fi
  done
}

function init_bridge()
{
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

function update_ubuntu()
{
  multipass exec ${vmname} -- sudo apt -y update
  multipass exec ${vmname} -- sudo apt -y upgrade
  multipass exec ${vmname} -- sudo apt -y autoremove
  multipass exec ${vmname} -- sudo apt -y autoclean
}

function hypervisor_setup()
{
  multipass get local.driver | grep lxd
  ret=$?
  if [ $ret -eq 0 ]; then
    return
  fi
  echo multipass set local.driver=lxd
  multipass set local.driver=lxd
  echo
}

function sshd_setup()
{
  multipass exec ${vmname} -- bash -c "echo -e '${loginpw}\n${loginpw}' | sudo passwd ubuntu"
  multipass exec ${vmname} -- sudo sed -r -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
  multipass exec ${vmname} -- sudo systemctl restart sshd
}

function install_app()
{
  multipass exec ${vmname} -- sudo apt -y install curl git vim
}

vmname_setup
show_all_network_interface
bridgename_setup
confirm_install

init_bridge

init_multipass

wait_multipass_ready

hypervisor_setup

wait_multipass_ready

echo multipass launch --name ${vmname} "20.04" --network ${bridge_interface}
multipass launch --name ${vmname} "20.04" --network ${bridge_interface}
echo

wait_multipass_ready

update_ubuntu

sshd_setup

install_app

show_multipass_info

show_instance_info

echo Note: You can ssh to ${vmname} with user ubuntu and password ${loginpw}
echo
