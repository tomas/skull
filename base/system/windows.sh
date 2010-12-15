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
	echo "$PROCESSOR_ARCHITEW6432" | grep "64" 1> /dev/null && echo 'x64' || echo 'x86'
}

####################################################################
# os version
####################################################################

System.os.version(){
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
		ver.destroy
	fi
	echo $System__OS_VERSION
}

System.os.version.vista_and_above(){
	[ `Number.is_greater_than \`System.os_version\` 6` ] && echo 1
}

System.os.version.xp_and_below(){
	[ `Number.is_greater_than 6 \`System.os_version\`` ] && echo 1
}

System.os.version.name(){
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

####################################################################
# session
####################################################################

System.logged_user.name(){
	echo "ComputerSystem Get Username" | wmic 2> /dev/null | grep -v 'wmic:' | grep -v "^$" | tail -1 | sed 's/.*\\\//'
}

System.logged_user.id(){
	Process.id 'explore.exe'
}

####################################################################
# paths
####################################################################

System.paths.root(){ echo 'C:\'; }

System.paths.os(){ echo "$WINDIR"; }

System.paths.temp(){ echo "$WINDIR\Temp"; }

System.paths.programs(){ [ `System.64_bit` ] && echo "C:\Program\ Files\ \(x86\)" || echo "C:\Program\ Files"; }

System.paths.users(){ [ `Dir.exists "C:\Users"` ] && echo "C:\Users" || echo "C:\Documents\ and\ Settings"; }

System.paths.home(){ echo "`System.users_path`\\`System.logged_user.name`"; }
