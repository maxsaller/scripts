#!/bin/bash
#
# Simple update script, includes apt, pip and atom apm
#

sudo echo -e "\nPACMAN"
sudo pacman -Syu

echo -e "\nPIP\n"
pip list --outdated | tail -n+3 | grep -v 'pip' | awk '{print $1}' | xargs pip install --user --upgrade
