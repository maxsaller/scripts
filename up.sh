#!/bin/bash
#
# Simple update script, includes apt, pip and atom apm
#

function update_apt () {
	sudo apt update
	echo ''
	sudo apt full-upgrade
	echo ''
	sudo apt autoremove
	echo ''
}

function update_pip () {
	/usr/local/bin/pip list --no-cache-dir --outdated | tail -n+3 | awk '{print $1}' | xargs /usr/local/bin/pip install --user --upgrade
    /usr/local/bin/pip3 list --no-cache-dir --outdated | tail -n+3 | awk '{print $1}' | xargs /usr/local/bin/pip3 install --user --upgrade

}

function update_atom () {
	apm update
	apm upgrade
}


echo 'UPDATING'
echo ''


if [ $# -lt 1 ]
then
	update_apt
	update_pip
	update_atom
else
	case $1 in
		'apt')
			update_apt
			;;
		'pip')
			update_pip
			;;
		'atom')
			update_atom
			;;
		'all')
			update_apt
			update_pip
			update_atom
			;;
	esac
fi


echo ''
echo 'ALL DONE'
