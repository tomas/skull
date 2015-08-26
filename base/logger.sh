#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

Log__OUTPUT=""
[ -z "$Log__LEVEL" ] && Log__LEVEL='info'

Log.info() {
  if [[ "$1" != "" && "$Log__LEVEL" != 'error' ]]; then
    Log.write "[info]\t$1"
  fi
}

alias log='Log.info'

Log.debug() {
  if [[ "$1" != "" && "$Log__LEVEL" == 'debug' ]]; then
    Log.write "[debug]\t$1"
  fi
}

alias debug='Log.debug'

Log.error() {
  if [[ "$1" != "" && "$Log__LEVEL" != 'info' ]]; then
    Log.write "[error]\t$1"
  fi
}

alias error='Log.error'

Log.write() {
  eval echo -e '"$1"' "$Log__OUTPUT"
}
