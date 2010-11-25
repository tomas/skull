#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

System.logged_user.name(){ who | cut -d' ' -f1 | sort -u | tail -1; }

alias System.logged_user="System.logged_user.name"

# this gives us the pts/tty the user's on
System.logged_user.id(){ Process.id "loginwindow.app" }

System.os_version(){
	[ -z "$System__OS_VERSION" ] && System__OS_VERSION=`sw_vers -productVersion | cut -c1-4`
	echo $System__OS_VERSION
}

System.os_version_name(){
	if [ -z "$System__OS_VERSION_NAME" ]; then
		if [ `Number.greater_or_equal_than \`System.os_version\` 10.6` ]]; then
			System__OS_VERSION_NAME="Snow Leopard"
		elif [ `Number.greater_or_equal_than \`System.os_version\` 10.5` ]]; then
			System__OS_VERSION_NAME="Leopard"
		elif [ `Number.greater_or_equal_than \`System.os_version\` 10.4` ]]; then
			System__OS_VERSION_NAME="Tiger"
		else
			System__OS_VERSION_NAME="Unknown"
		fi
	fi
	echo $System__OS_VERSION_NAME
}

System.root_path(){ echo "/"; }

System.temp_path(){ echo '/tmp'; }

System.system_path(){ echo "/etc"; }

System.users_path(){ echo "/home"; }

System.programs_path(){ echo '/usr'; }

System.home_path(){ eval echo ~; }
