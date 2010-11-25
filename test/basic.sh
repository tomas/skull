#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

echo " -- Start time: `date`"

PATH=/bin:/sbin:/usr/bin:/usr/sbin:$PATH
base_path=`dirname $0`

# Log__LEVEL=debug

readonly skull_path="${base_path}/../"
. "${skull_path}/init"

#########################
# classes & instances
#########################

log 'Testing Class'

Array.new arr
should_equal `Array.instances.count` 1
arr.destroy
should_equal `Array.instances.count` 0

String.new str 'hello world'
String.new str 'hello other world' # should overwrite previous instance

should_equal `String.instances.count` 1 # as the other one was overwritten
str.destroy
should_equal `String.instances.count` 0

#########################
# hashes
#########################

log 'Testing Hash'

Hash.new h

should_equal "`h.count`" 0

h.store foo bar
should_equal "`h.count`" 1
h.store one two
should_equal "`h.count`" 2

should_be "`h.get 'foo'`" 'bar'
should_be "`h.get 'one'`" 'two'

# h.all
h.destroy

#########################
# arrays
#########################

log 'Testing Array'

Array.new arr

arr.push 'one'
arr.push 'two'
arr.push 'three'
should_equal `arr.count` 3

arr.delete 1
should_equal `arr.count` 2

arr.destroy

#########################
# strings
#########################

log 'Testing String'

String.new str 'Hello world'

should_be "`str`" "Hello world"
should_be "`str.upcase`" 'HELLO WORLD'
should_be "`str.downcase`" 'hello world'
should_be "`str.sanitize`" 'hello-world'
should_be "`str.urlencode`" 'Hello%20world'
should_be "`str.encrypt`" 'SGVsbG8gd29ybGQ='

str.destroy

String.new str
should_be "`str`" ""

#########################
# xml
#########################

#XmlNode.new line '<foo name="skull">bar</foo>'

#should_be `line.key` 'foo'
#should_be `line.value` 'bar'
#should_be `line.attribute "name"` 'skull'

show_test_results
echo " -- End time: `date`"
