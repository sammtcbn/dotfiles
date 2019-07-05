#!/bin/bash
# Install Eclipse Paho MQTT C client library for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.7.5
if [ "$EUID" -ne 0 ]; then
    echo "Please run as root"
    exit
fi

apt update
apt -y install libssl-dev doxygen graphviz
git clone https://github.com/eclipse/paho.mqtt.c.git
cd paho.mqtt.c
make
make html
make install
