#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

Hash__METHODS=(all count delete each_pair find get keys values store size)

####################################################
# methods
####################################################

# initialize hash: 	Hash.new [hash_name]
# add element: 			hash_name.store key value
# count elements		hash_name.count
# get element: 			hash_name.get key
# loop elements: 		hash_name.all | while read key val; do ... done

# this overrides the class eval'd .send method
# as we need to pass the descriptor to the methods
Hash.send(){
	eval Hash.${1} \"${2}\" \"${3}\" \"${4}\" \"${5}\"
}

# Function to return hash itens
Hash.all(){
	for key in `Array.all "${1}"`; do
		echo $key `Hash.get "${1}" "${key}"`
	done
}

# Function returns hash size

alias Hash.count='Array.count'
alias Hash.size='Hash.count'

# Function remove a item by index
Hash.delete(){
	required "$1" "$2" && unset ${1}[${2}] && unset ${1}__${2}
}

#Hash.each_pair(){
#	${1}.all | while read key val
#}

# get item from hash
Hash.get(){
	required "$1" "$2" && eval echo \$${1}__${2}
}

# Function search patterns in items
Hash.find(){
	for i in \${!${1}[@]}; do
		[[ \${${1}[i]} =~ \${1} ]] && echo \"\${${1}[i]}\"
	done
}

# store the keys in array, declare the other one as a new var
Hash.store() {
	required "$1" "$2" "$3" || return 1
	Array.push "$1" "$2"
	eval ${1}__$2="$3"
}
