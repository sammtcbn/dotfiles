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

multipass exec ${vmname} -- bash -c "echo -e '1234\n1234' | sudo passwd ubuntu"

multipass exec ${vmname} -- sudo sed -r -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
multipass exec ${vmname} -- sudo systemctl restart sshd

echo multipass networks
multipass networks
echo

echo multipass list
multipass list
echo

echo multipass info ${vmname}
multipass info ${vmname}
echo

echo SSH logon to ${vmname} with id Ubuntu and password 1234

