#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.8.5
mkdir -p ~/bin/ || exit 1
cp -f bin_for_linux/* ~/bin/ || exit 1
cp -f dot/vimrc ~/.vimrc || exit 1
cp -f dot/dircolors ~/.dircolors || exit 1
cp -f dot/bash_aliases ~/.bash_aliases || exit 1

echo "setup ok"
