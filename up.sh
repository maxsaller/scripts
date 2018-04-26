#!/bin/bash
#
# Simple update script, includes apt, pip and atom apm
#

echo 'UPDATING'
echo ''

sudo apt update
echo ''
sleep 1
sudo apt full-upgrade
echo ''
sleep 1
sudo apt autoremove
echo ''

pip list --outdated | tail -n+3 | cut -d ' ' -f1 | xargs sudo -H pip install -U
echo ''
sleep 1
pip3 list --outdated | tail -n+3 | cut -d ' ' -f1 | xargs sudo -H pip3 install -U
echo ''

sudo apm update
sudo apm upgrade
sleep 1

echo ''
echo 'ALL DONE'
