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

exit 0

###################################################

apt-get -y install sharutils
apt-get -y install bison flex texinfo gettext
apt-get -y install lib32z1-dev
apt-get -y install lzma liblzma-dev
apt-get -y install zlib1g-dev
apt-get -y install ccache
apt-get -y install device-tree-compiler
apt-get -y install u-boot-tools
apt-get -y install libncurses5-dev


