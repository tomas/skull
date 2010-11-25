Skull
======

Skull is a Bash framework that provides an object-oriented-like layer for writing shell scripts, or just for working on the terminal.

Most of the stuff comes out of [Prey][1] but since it has been growning a bit, I decided to turn it into a framework on its own. Skull is written purely in Bash and doesn't have any special requirements. Just drop and use.

Overview
--------

Bash is awesome for many things, but doesn't have any way of working with objects. In fact, most of the stuff you normally do in Ruby/Python/etc is simply a method call, but normally in shell scripts you need to pipe a command into another and another, and perhaps another one too -- e.g. getting your IP address from ifconfig.

Besides, there is usually stuff that works differently in Mac than Linux, mostly because of the difference between the GNU vs BSD variants of commands. Windows? Well, that's anooother story.

Skull provides a unified interface for working with strings, arrays, hashes, processes, etc in Bash. You can also "instantiate" objects and benefit from a easy interface to work with them.

Bash's syntax is actually quite similar to Ruby, so I figured it wouldn't be too hard to make Bash become more ruby-like. Those are the main reasons why I did this.

Code
----

In Ruby you could work with an array like this:

  >> a = Array.new
  >> a.push 'foo'
  >> a.count # => 1

Skull allows you to do pretty much the same, only without Ruby. Just plain ol' Bash.

  \$ Array.new a
  \$ a.push 'foo'
  \$ a.count # => 1

Yes, this *is* Bash.

How it works
------------

Skull uses aliases as a way to attach "instance methods" to objects. So what Array.new is actually doing is associating a set of aliases an functions -- as declared by the Array "class" -- to the a element.

How to use
----------

- Get a tarball or clone the repo:

  >> git clone https://github.com/tomas/skull.git .

- If you want to use Skull in a script, you need to declare the path and source the init script.

	#!/bin/bash
  skull_path='/usr/share/skull'
  . "${skull_path}/init"

- If you want to use Skull from the command line, source the init script with the -i argument. Just put this in your ~/.bashrc.

  . "/usr/share/skull/init" -i

- Now you can start playing around!

	String.new str 'hello world'
	str.titleize
	str.length

Note on Patches/Pull Requests
-----------------------------

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit
* Send me a pull request. Bonus points for topic branches.


Copyright
---------

A project by Tomás Pollak.
Copyright (c) 2010 Fork Ltd. See LICENSE for details.

[1]: https://github.com/tomas/prey
