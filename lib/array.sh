#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

Array__METHODS=(all count delete each each_index find get index push split size)

####################################################
# methods
####################################################

# this method is only called once (when array class is being created)
# we need it so the class loader doesnt break when loading this class
Array.new(){
	debug "Array class being initialized."
	for method in ${Array__METHODS[@]}; do
		eval "alias ${1}.${method}='Array.${method} ${1} '"
	done
	# eval "alias ${1}.destroy='Function.protected'"
}

# this overrides the class eval'd .send method
# as we need to pass the descriptor to the methods
Array.send(){
	: ${2:?"No description given."}
	eval Array.${1} \"${2}\" \"${3}\" \"${4}\"
}

Array.all(){
	required "$1" && eval echo \${$1[@]}
}

# returns list of array indexes
# eg. => 0 1 3 4 6
Array.index(){
	required "$1" && eval echo \${!${1}[@]}
}

# returns array size
Array.count(){
	required "$1" && eval echo \${#${1}[@]}
	# required "$1" && Array.index "$1" | wc -w
}

alias Array.size='Array.count'

# get index of first element with value
Array.find(){
	for i in `Array.index ${1}`; do
		[ "$(Array.get $1 $i)" == "$2" ] && echo $i && return
	done
}

# get element by index
Array.get(){
	required "$1" "$2" && eval echo \${${1}[\${2}]}
}

Array.delete(){
	required "$1" "$2" && unset ${1}[\${2}]
}

Array.push(){
	required "$1" "$2" || return 1
	local index=$(Array.index "$1")
	# we need to get the last element's index so we append the last element
	# instead of overwriting it, in case an element was removed
	[ -n "$index" ] && local new_index=$((${index#${index%?}}+1)) || local new_index=0
	eval ${1}[$new_index]="${2}"
	return ${new_index} # element index
}

# returns subarray
# @param 2 start index
# @param 3 number of elements
Array.split() {
	required "$1" "$2" "$3" && eval echo \${${1}[@]:${2}:${3}}
}
