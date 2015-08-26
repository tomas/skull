#!/bin/bash
####################################################################
# SKULL Framework - by Tomas Pollak (github.com/tomas)
# (c) 2010 - Fork Ltd
# License: GPLv3
####################################################################

####################################################################
# arch
####################################################################

System.arch() {
  [ $(uname -m) == 'x86_64' ] && echo 'x64' || echo 'x86'
}

####################################################################
# os version
####################################################################

System.os.version() {
  [ -z "$System__OS_VERSION" ] && System__OS_VERSION=$(sw_vers -productVersion | cut -c1-4)
  echo $System__OS_VERSION
}

# TODO: refactor or remove this
System.os.version.name() {
  if [ -z "$System__OS_VERSION_NAME" ]; then
    if [ $(Number.greater_or_equal_than $(System.os.version) 10.10) ]; then
      System__OS_VERSION_NAME="El Capitan"
    elif [ $(Number.greater_or_equal_than $(System.os.version) 10.9) ]; then
      System__OS_VERSION_NAME="Yosemite"
    elif [ $(Number.greater_or_equal_than $(System.os.version) 10.8) ]; then
      System__OS_VERSION_NAME="Mavericks"
    elif [ $(Number.greater_or_equal_than $(System.os.version) 10.8) ]; then
      System__OS_VERSION_NAME="Mountain Lion"
    elif [ $(Number.greater_or_equal_than $(System.os.version) 10.7) ]; then
      System__OS_VERSION_NAME="Lion"
    elif [ $(Number.greater_or_equal_than $(System.os.version) 10.6) ]; then
      System__OS_VERSION_NAME="Snow Leopard"
    elif [ $(Number.greater_or_equal_than $(System.os.version) 10.5) ]; then
      System__OS_VERSION_NAME="Leopard"
    elif [ $(Number.greater_or_equal_than $(System.os.version) 10.4) ]; then
      System__OS_VERSION_NAME="Tiger"
    else
      System__OS_VERSION_NAME="Unknown"
    fi
  fi
  echo $System__OS_VERSION_NAME
}

####################################################################
# session
####################################################################

System.logged_user.name() {
  who | awk '{ print $1 }' | tail -1
}

# this gives us the pts/tty the user's on
System.logged_user.location() {
  who | awk '{ print $2 }' | tail -1
}

System.logged_user.id() {
  id -u $(System.logged_user.name)
}

System.logged_user.session_id() {
  Process.id "loginwindow.app"
}

####################################################################
# paths
####################################################################

System.paths.root() { echo "/"; }

System.paths.temp() { echo '/tmp'; }

System.paths.os() { echo "/Library"; }

System.paths.users() { echo "/Users"; }

System.paths.programs() { echo "/Applications"; }

System.paths.home() { eval echo ~; }
