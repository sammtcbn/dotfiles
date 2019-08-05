#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.8.5
mkdir -p ~/bin/ || exit 1
cp -f bin/* ~/bin/ || exit 1
cp -f git_script/* ~/bin/ || exit 1
cp -f dot/vimrc ~/.vimrc || exit 1
cp -f dot/dircolors ~/.dircolors || exit 1
echo "setup ok"
