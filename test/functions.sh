#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

##########################################
# test functions
##########################################

passed_tests=0
failed_tests=0

passed() {
	passed_tests=$(($passed_tests+1))
	log "++ PASSED"
}
failed() {
	failed_tests=$(($failed_tests+1))
	log "!! FAILED, expected $2, got $1"
	# exit
}

should_be(){
	[ "$1" == "$2" ] && passed || failed "$1" "$2"
}

should_not_be(){
	[ "$1" != "$2" ] && passed || failed "$1" "$2"
}

# for numeric expressions
should_equal(){
	[ $1 -eq $2 ] && passed || failed $1 $2
}

should_include(){
	[[ `grep "$1" "$2" > /dev/null` ]] && passed || failed "$1" "$2"
}

should_not_include(){
	[[ `grep "$1" "$2" > /dev/null` ]] && failed "$1" "$2" || passed
}

show_test_results(){
	echo -e "\n##########################################"
	echo -e "# Results:"
	echo -e "# Passed: $passed_tests --- Failed: $failed_tests"
	echo -e "##########################################\n"
}
