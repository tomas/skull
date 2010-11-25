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
	elif [ "$os" == "darwin" ];
		then os=mac
	fi

	# readonly os

	. "${skull_path}/base/system/${os}.sh"
	. "${skull_path}/base/system/base.sh"

	# os speficic stuff
	# readonly os_version=`System.os_version` # '10.10', '6.0' or '10.5'
	# readonly os_version_name=`System.os_version_name` # 'Ubuntu' or 'Vista' or 'Snow Leopard'

	# system/user paths
	# readonly root_path='System.root_path'
	# readonly temp_path='System.temp_path'

	# session stuff
	# readonly logged_user=`System.logged_user`
	# readonly logger_pid=`System.logged_user_pid`
	# readonly home_path='System.home_path'

}

Env.unset(){
	unset os # os_version os_version_name root_path temp_path home_path logged_user logged_user_pid
}
