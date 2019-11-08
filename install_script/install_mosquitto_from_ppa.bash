#!/bin/bash
# Install Mosquitto Broker for Ubuntu
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.12.21
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

apt-add-repository -y ppa:mosquitto-dev/mosquitto-ppa
apt update
apt -y install mosquitto
apt -y install mosquitto-clients
