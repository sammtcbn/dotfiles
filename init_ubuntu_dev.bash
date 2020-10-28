#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.10.26
apt update
apt -y install git
apt -y install build-essential
# build-essential consists of lib6-dev, gcc, g++, make, dpkg-dev
apt -y install automake autoconf
apt -y install libtool
apt -y install m4
apt -y install cmake
#apt -y install subversion

apt -y install apt-file
apt-file update
