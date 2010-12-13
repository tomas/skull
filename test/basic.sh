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

current_path=`dirname "$0"`
. "${current_path}/../init"
. "${current_path}/functions.sh"

#########################
# classes & instances
#########################

log 'Testing Class'

Array.new my_arr
should_equal `Array.instances.count` 1
my_arr.destroy
should_equal `Array.instances.count` 0

String.new my_str 'hello world'
String.new my_str 'hello other world' # should overwrite previous instance

should_equal `String.instances.count` 1 # as the other one was overwritten
my_str.destroy
should_equal `String.instances.count` 0

#########################
# hashes
#########################

log 'Testing Hash'

Hash.new hh

should_equal "`hh.count`" 0

hh.store foo bar
should_equal "`hh.count`" 1
hh.store one two
should_equal "`hh.count`" 2

should_be "`hh.get 'foo'`" 'bar'
should_be "`hh.get 'one'`" 'two'

# hh.all
hh.destroy

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
should_be "`str.capitalize_once`" 'Hello world'
should_be "`str.capitalize_all`" 'Hello World'
should_be "`str.sanitize`" 'hello-world'
should_be "`str.urlencode`" 'Hello%20world'
should_be "`str.encrypt`" 'SGVsbG8gd29ybGQ='

str.destroy

String.new str
should_be "`str`" ""

#########################
# xml
#########################

Class.new XmlNode
XmlNode.new line '<foo name="skull">bar</foo>'

should_be `line.key` 'foo'
should_be `line.value` 'bar'
should_be `line.attribute "name"` 'skull'

show_test_results
echo " -- End time: `date`"
