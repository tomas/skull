#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

Alias.exists() {
	type $1 2> /dev/null | grep -q 'is aliased to' && echo 1
}

Function.exists() {
	type $1 2> /dev/null | grep -q 'is a function' && echo 1
}

Function.protected(){
	error "Invalid request." && return 1
}

# helper function for verifying args in functions
required(){
	for i in @#; do
		local arg=`eval echo \\\$$i`
		[ "$arg" == "" ] && echo "Missing arguments." && return 1
	done
	return 0
}
