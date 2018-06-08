#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.6.8
apt update
apt -y install git
apt -y install build-essential
# build-essential consists of lib6-dev, gcc, g++, make, dpkg-dev
apt -y install automake autoconf
apt -y install libtool
apt -y install cmake
