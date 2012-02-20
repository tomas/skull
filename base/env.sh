#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

Env.set(){
	os=`uname | tr '[:upper:]' '[:lower:]'`

	if [ "$os" == "windowsnt" ]; then
		os=windows
	elif [ "$os" == "darwin" ]; then 
		os=mac
	fi

	# readonly os

}

Env.unset(){
	unset os # os_version os_version_name root_path temp_path home_path logged_user logged_user_pid
}
