#!/bin/bash
# Install Node-Red for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.11.12
# ref to https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

npm install -g --unsafe-perm node-red node-red-admin node-red-dashboard
ufw allow 1880

#NODERED_HOME=$HOME
NODERED_HOME=$( getent passwd "$USER" | cut -d: -f6 )
NODERED_USER=$USER
NODERED_GROUP=`id -gn`
echo nodered home is $NODERED_HOME
echo nodered user is  $NODERED_USER
echo nodered group is $NODERED_GROUP

SERVICEFILE=/lib/systemd/system/nodered.service
sudo curl -sL -o $SERVICEFILE https://raw.githubusercontent.com/node-red/linux-installers/master/resources/nodered.service

echo node-red service file is $SERVICEFILE

# set the User Group and WorkingDirectory in nodered.service
sudo sed -i 's#^User=pi#User='$NODERED_USER'#;s#^Group=pi#Group='$NODERED_GROUP'#;s#^WorkingDirectory=/home/pi#WorkingDirectory='$NODERED_HOME'#;' $SERVICEFILE

sudo systemctl daemon-reload
sudo systemctl enable nodered.service
sudo systemctl start nodered.service
