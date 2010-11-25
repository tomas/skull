#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

System.logged_user.name(){
	echo "ComputerSystem Get Username" | wmic 2> /dev/null | grep -v 'wmic:' | grep -v "^$" | tail -1 | sed 's/.*\\\//'
}

alias System.logged_user="System.logged_user.name"

System.logged_user.id(){
	Process.id explore.exe
}

System.os_version(){
	if [ -z "$System__OS_VERSION" ]; then
		String.new ver `ver`
		if [ `String.contains 2003` ]; then
			System__OS_VERSION=2003
		elif [ `String.contains XP` ]; then
			System__OS_VERSION=XP
		elif [ `String.contains 2000` ]; then
			System__OS_VERSION=2000
		elif [ `String.contains NT` ]; then
			System__OS_VERSION=NT
		fi
	fi
	echo $System__OS_VERSION
}

System.os_version.vista_and_up(){
	[ `Number.is_greater_than \`System.os_version\` 6` ] && echo 1
}

System.os_version.xp_or_older(){
	[ `Number.is_greater_than 6 \`System.os_version\`` ] && echo 1
}

System.os_version_name(){
	if [ -z "$System__OS_VERSION_NAME" ]; then
		if [ `String.contains 2003` ]; then
			System__OS_VERSION=2003
		elif [ `String.contains XP` ]; then
			System__OS_VERSION=XP
		elif [ `String.contains 2000` ]; then
			System__OS_VERSION=2000
		elif [ `String.contains NT` ]; then
			System__OS_VERSION=NT
		fi
	fi
	echo $System__OS_VERSION_NAME
}

System.temp_path(){
	echo "$WINDIR\Temp"
}

System.arch(){
	echo "$PROCESSOR_ARCHITEW6432" | grep "64" 1> /dev/null && echo 'x64' || echo 'x86'
}

System.64_bit(){
	[ `System.arch` == 'x64' ] && echo 1
}

System.root_path(){ echo 'C:\' }

System.os_path(){ echo "$WINDIR" }

System.programs_path(){
	[ `System.64_bit` ] && echo "C:\Program\ Files\ \(x86\)" || echo "C:\Program\ Files"
}

System.users_path(){
	[ `Dir.exists "C:\Users"` ] && echo "C:\Users" || echo "C:\Documents\ and\ Settings"
}

System.home_path(){
	echo "`System.users_path`\\`System.logged_user.name`"
}
