#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2017.12.15
mkdir -p ~/bin/ || exit 1
cp -f bin/* ~/bin/ || exit 1
echo "setup ok"
