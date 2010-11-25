#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

String__METHODS=(capitalize contains downcase decrypt encrypt length md5sum sanitize urlencode urldecode size titleize upcase)

[ "$os" == 'windows' ] && String__LINE_BREAK='\r\n' || String__LINE_BREAK='\n'

####################################################
# methods
####################################################

# echoes 1 if needle is found in haystack, expects haystack as $1, needle as $2
# usage find_in 'foobar' 'foo' -> echoes 1
String.contains(){
	echo "${1}" | grep "${2}" 1> /dev/null && echo 1
}

# returns length of string
String.length(){
	echo "$1" | wc -c
}

alias String.size="String.length"

# returns lowercased string, expects string as $1
String.downcase(){
	echo "$1" | tr '[:upper:]' '[:lower:]'
}

String.upcase(){
	echo "$1" | tr '[:lower:]' '[:upper:]'
}

String.capitalize(){
	echo "$1" | sed -r 's/\b(.)/\U\1/g'
	# echo "$1" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1'
}

String.titleize(){
	echo "$1" | sed -r -e "s/-|_/ /g" -e 's/\b(.)/\U\1/g'
}

String.sanitize(){
	[ -n "$2" ] && local sanitizer="$2" || local sanitizer="-"
	String.downcase "$1" | sed -r -e "s/[^a-zA-Z -_]//g" -e "s/-|_| /${sanitizer}/g"
}

# returns a urlencoded string, expects string as $1
String.urlencode(){
	echo "$1" | tr $String__LINE_BREAK "^" | sed -e 's/%/%25/g;s/ /%20/g;s/!/%21/g;s/"/%22/g;s/#/%23/g;s/\$/%24/g;s/\&/%26/g;s/=/%3D/g;s/'\''/%27/g;s/(/%28/g;s/)/%29/g' -e "s/\^$//;s/\^/%0A/g"
}

String.urldecode(){
	echo "$1" | sed "s/%0A/\n/g;s/%22/\"/g;s/%28/\(/g;s/%29/\)/g;s/%26/\&/g;s/%3D/\=/g"
}

# returns the md5 hash for a string, expects string as $1
String.md5sum(){
	[ "$os" == "mac" ] && local md5="/sbin/md5 -r" || local md5=`which md5sum`
	(echo -n "$1" | $md5 | sed 's/.*\([a-f0-9]\{32\}\).*/\1/')
}

# returns base64 encoded string, expects string as $1
String.encrypt(){
	[ -n "$2" ] && local encoder="$2" || local encoder="base64"
	echo -n "$1" | openssl enc -${encoder}
}

# returns base64 decoded string, expects string as $1
String.decrypt(){
	[ -n "$2" ] && local decoder="$2" || local decoder="base64"
	echo "$1" | openssl enc -${decoder} -d
}
