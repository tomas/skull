#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

####################################################
# methods
####################################################

# returns 1 if int/float is greater than the second one, expects int/float at $1 and $2
Number.is_greater_than() {
	echo "$1 $2" | awk '{if ($1 > $2) print 1; else return 0}'
}

Number.is_greater_or_equal_than() {
	[ $1 -eq $2 ] && echo 1 || Number.is_greater_than $1 $2
}
