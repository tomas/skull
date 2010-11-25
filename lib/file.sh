#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

File__METHODS=(path dirname name basename extension extname size size.kb size.mb)

alias File.open='File.new'

File.size.bytes(){
	cat "$2" | wc -c
}

alias File.size='File.size.bytes'

File.size.kb(){
	echo $((`File.size.bytes "$2"`/1024))
}

File.size.mb(){
	echo $((`File.size.kb "$2"`/1024))
}

File.dirname(){
	dirname "${2}"
}

alias File.path='File.dirname'

File.basename(){
	basename "${2}"
	# echo "${1%.*}"
}

alias File.name='File.basename'

File.exists(){
	[ -f "$2" ] && echo 1
}

File.modified_at(){
	stat -c %y "$2" | cut -d ' ' -f1
}

File.extname(){
	echo "${2##*.}"
}

alias File.extension='File.extname'
