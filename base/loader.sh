#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

load(){
	for lib in $@; do
		if [ -d "$lib" ]; then
			load "$lib/base.sh" "$lib/$os.sh"
		elif [ -f "$lib" ]; then
			. "$lib"
		fi
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
