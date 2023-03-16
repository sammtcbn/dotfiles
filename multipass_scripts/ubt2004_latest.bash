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
sudo snap install multipass --classic

wait_multipass_ready

#multipass launch -c 2 -m 2G -d 8G -n ubt2004
multipass launch --name ${vmname} "20.04"

wait_multipass_ready

multipass exec ${vmname} -- sudo apt -y update
multipass exec ${vmname} -- sudo apt -y upgrade
multipass exec ${vmname} -- sudo apt -y autoremove
multipass exec ${vmname} -- sudo apt -y autoclean

echo multipass networks
multipass networks
echo

echo multipass list
multipass list
echo

echo multipass info ${vmname}
multipass info ${vmname}
