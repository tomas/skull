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

alias XmlNode.val="XmlNode.value"

# expects attr name, returns value
# example: get_attribute 'name' $line
XmlNode.attribute(){
  required "$1" "$2" && echo "$1" | sed -e "s/.*$2=\([^ \"'>]*\).*/\1/"
}

alias XmlNode.attr="XmlNode.attribute"
