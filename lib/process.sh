#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

# this class is not instantiated when Skull is loaded. methods are 'public'

####################################################
# methods

[ "$os" == 'windows' ] && alias Process.list='TASKLIST' || alias Process.list='ps ax'

# echoes 1 if process is running, expects process full name (eg. 'firefox-bin')
Process.running() {
  : ${1:?"No process name given."}
  Process.list | grep -v grep | grep "$1" > /dev/null && echo 1
}

# returns number of instances of a process, expects process full name
Process.count() {
  : ${1:?"No process name given."}
  Process.list | grep -v grep | grep -v $$ | grep "$1" | wc -l
}

# returns pid for the requested process, expects the full process name
Process.id() {
  : ${1:?"No process name given."}

  if [ "$os" == "windows" ]; then
    Process.list | grep "$1" | head -1 | sed 's/[a-z\. ]*\([0-9]*\).*/\1/'
  else
    Process.list | grep -i "$1" | grep -v grep | head -1 | sed 's/ \?\([0-9]*\).*/\1/'
  fi
}

# kills a specified process, expects the process name
Process.kill() {
  : ${1:?"No process name given."}

  [ -n "$2" ] && local signal="$2" || local signal="-TERM"
  local pid=$(Process.id "$1")
  if [ -n "$pid" ]; then
    kill $signal $pid 2> /dev/null
  fi
}
