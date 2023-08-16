#!/bin/bash
apt-get -y update
apt-get -y install git
apt-get -y install build-essential
# build-essential consists of lib6-dev, gcc, g++, make, dpkg-dev
apt-get -y install automake autoconf
apt-get -y install libtool
apt-get -y install m4
apt-get -y install cmake
#apt -y install subversion

apt-get -y install apt-file
apt-get -y install dos2unix

apt-file update
