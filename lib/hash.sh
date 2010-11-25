#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

####################################################
# class constants
####################################################

####################################################
# methods
####################################################

# initialize hash: 	hash.new [name]
# add element: 			hash[key] = value
# count elements		hash.count
# get element: 			hash.get key
# loop elements:		hash.each_pair

Hash__METHODS=(all count delete each_pair find get keys values store size)

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
	unset ${1}[${2}] && unset ${1}__${2}
}

#Hash.each_pair(){
#	${1}.all | while read key val
#}

# get item from hash
Hash.get(){
	eval echo \$${1}__${2}
}

# Function search patterns in items
Hash.find(){
	for i in \${!${1}[@]}; do
		[[ \${${1}[i]} =~ \${1} ]] && echo \"\${${1}[i]}\"
	done
}

# store the keys in array, declare the other one as a new var
Hash.store() {
	Array.push "$1" "$2"
	eval ${1}__$2="$3"
}
