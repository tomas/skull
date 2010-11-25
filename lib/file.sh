#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

File__METHODS=(path dirname name basename extension extname size size.kb size.mb)

####################################################
# methods
####################################################


alias File.open='File.new'

File.size.bytes(){
	cat "$1" | wc -c
}

alias File.size='File.size.bytes'

File.size.kb(){
	echo $((`File.size.bytes "$1"`/1024))
}

File.size.mb(){
	echo $((`File.size.kb "$1"`/1024))
}

File.dirname(){
	dirname "${1}"
}

alias File.path='File.dirname'

File.basename(){
	basename "${1}"
	# echo "${1%.*}"
}

alias File.name='File.basename'

File.exists(){
	[ -f "$1" ] && echo 1
}

File.modified_at(){
	stat -c %y "$1" | cut -d ' ' -f1
}

File.extname(){
	echo "${1##*.}"
}

alias File.extension='File.extname'
