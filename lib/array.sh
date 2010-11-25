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

# returns array index
Array.index(){
	required "$1" && eval echo \${!${1}[@]}
}

# returns array size
Array.count(){
	required "$1" && eval echo \${#${1}[@]}
}

alias Array.size='Array.count'

# get index of element with value
Array.find(){
	for i in `Array.index ${1}`; do
		[[ \${${1}[i]} =~ \${1} ]] && echo $1 && return
		# [ "`Array.get ${i}`" =~ "${2}" ] && echo ${i} && return
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
	local count=`Array.count "$1"`
	eval ${1}[$count]="${2}"
	return ${count}
}

# Function to split a subarray
Array.split() {
	echo "\${${1}[@]:\${1}:\${2}}"
}
