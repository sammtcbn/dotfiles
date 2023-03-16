#!/bin/bash
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

vmname=ubt2004

echo sudo snap install multipass --classic
sudo snap install multipass --classic
echo

wait_multipass_ready

echo multipass launch --name ${vmname} "20.04"
multipass launch --name ${vmname} "20.04"
echo

wait_multipass_ready

echo multipass networks
multipass networks
echo

echo multipass list
multipass list
echo

echo multipass info ${vmname}
multipass info ${vmname}
