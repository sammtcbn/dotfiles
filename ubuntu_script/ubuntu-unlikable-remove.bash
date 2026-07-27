#!/bin/bash
sudo apt -y purge thunderbird rhythmbox gnome-todo gnome-calendar transmission-gtk transmission-common libreoffice* remmina
sudo apt -y autoremove
sudo apt -y autoclean
