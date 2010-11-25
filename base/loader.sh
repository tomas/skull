#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

load(){
	for lib in $1; do
		[ ! -f "$lib" ] && continue
		source "$lib"
	done
	unset lib
}

init_classes(){
	for class_name in $@; do
		Class.new $class_name
	done
	unset class_name
}

unload_classes(){
	for class_name in $@; do
		Class.unload $class_name
	done
	unset class_name
}

required(){
	for i in `seq 1 $#`; do
		local arg=`eval echo \\\$$i`
		[ "$arg" == "" ] && echo "Missing arguments." && return 1
	done
	return 0
}
