#!/bin/bash
# install Google Chrome for Ubuntu 64-bit
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2018.12.22

echo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb || exit 1

echo
echo dpkg -i google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb || exit 1

echo
echo rm -f google-chrome-stable_current_amd64.deb
rm -f google-chrome-stable_current_amd64.deb || exit 1

echo
echo cat /etc/apt/sources.list.d/google-chrome.list
cat /etc/apt/sources.list.d/google-chrome.list || exit 1
echo

echo "Install chrome ... done"
