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

requires(){
	for i in `seq 1 $#`; do
		local arg=`eval echo \\\$$i`
		[ "$arg" == "" ] && echo "Missing params." && return 0
	done
	return 1
}
