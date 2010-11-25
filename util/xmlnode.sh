#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

XmlNode__METHODS=(key value attribute)

XmlNode.key(){
	echo "$1" | sed -e 's/.*\/\(.*\)>/\1/' -e 'y/-/_/' # we also replace -'s to _'s
}

XmlNode.value(){
	echo "$1" | sed 's/.*>\([^<].*\)<.*/\1/'
}

# expects attr name, returns value
# example: get_attribute 'name' $line
XmlNode.attribute(){
	echo "$1" | sed "s/.*$2=\"\([a-z_]*\)\".*/\1/"
}
