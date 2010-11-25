#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

System.logged_user.name(){
	who | cut -d' ' -f1 | sort -u | tail -1
}

alias System.logged_user="System.logged_user.name"

# this gives us the pts/tty the user's on
System.logged_user.id(){
	who | awk '{ print \$2 }' | sort -u | tail -1
}

System.os_version(){
	lsb_release -r | cut -f2
}

System.os_version_name(){
	head -1 /etc/issue | sed 's/\\.//g'
}

System.root_path(){ echo "/"; }

System.temp_path(){ echo '/tmp'; }

System.system_path(){ echo "/etc"; }

System.users_path(){ echo "/home"; }

System.programs_path(){ echo '/usr'; }

System.home_path(){ eval echo ~; }
