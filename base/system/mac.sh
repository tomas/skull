#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

####################################################################
# arch
####################################################################

System.arch(){
	[ `uname -m` == 'x86_64' ] && echo 'x64' || echo 'x86'
}

####################################################################
# os version
####################################################################

System.os.version(){
	[ -z "$System__OS_VERSION" ] && System__OS_VERSION=`sw_vers -productVersion | cut -c1-4`
	echo $System__OS_VERSION
}

System.os.version.name(){
	if [ -z "$System__OS_VERSION_NAME" ]; then
		if [ `Number.greater_or_equal_than \`System.os.version\` 10.6` ]; then
			System__OS_VERSION_NAME="Snow Leopard"
		elif [ `Number.greater_or_equal_than \`System.os.version\` 10.5` ]; then
			System__OS_VERSION_NAME="Leopard"
		elif [ `Number.greater_or_equal_than \`System.os.version\` 10.4` ]; then
			System__OS_VERSION_NAME="Tiger"
		else
			System__OS_VERSION_NAME="Unknown"
		fi
	fi
	echo $System__OS_VERSION_NAME
}

####################################################################
# session
####################################################################

System.logged_user.name(){
	who | cut -d' ' -f1 | sort -u | tail -1
}

System.logged_user.id(){
	Process.id "loginwindow.app"
}

####################################################################
# paths
####################################################################

System.paths.root(){ echo "/"; }

System.paths.temp(){ echo '/tmp'; }

System.paths.system(){ echo "/Library"; }

System.paths.users(){ echo "/Users"; }

System.paths.programs(){ echo "/Applications"; }

System.paths.home(){ eval echo ~; }
