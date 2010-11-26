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
	lsb_release -r | cut -f2
}

System.os.version.name(){
	head -1 /etc/issue | sed 's/\\.//g'
}

####################################################################
# session
####################################################################

System.logged_user.name(){
	who | cut -d' ' -f1 | sort -u | tail -1
}

# this gives us the pts/tty the user's on
System.logged_user.id(){
	who | awk '{ print $2 }' | sort -u | tail -1
}

####################################################################
# paths
####################################################################

System.paths.root(){ echo "/"; }

System.paths.temp(){ echo '/tmp'; }

# to be discussed :)
System.paths.os(){ echo "/etc"; }

System.paths.users(){ echo "/home"; }

System.paths.programs(){ echo '/usr'; }

System.paths.home(){ eval echo ~; }
