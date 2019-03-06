#!/bin/bash
# https://github.com/sammtcbn/dotfiles
# Written by sammtcbn 2019.3.6
mkdir -p ~/bin/ || exit 1
cp -f bin/* ~/bin/ || exit 1
cp -f git_script/* ~/bin/ || exit 1
echo "setup ok"
