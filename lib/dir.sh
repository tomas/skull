#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

####################################################
# methods
####################################################

Dir.exists(){
	[ -d "$1" ] && echo 1
}

Dir.full_path(){
	if [ "$1" != '.' ]; then
		cd "$1"
		echo $PWD
		cd - &> /dev/null
	else
		echo $PWD
	fi
}
