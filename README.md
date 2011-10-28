Skull
======

Skull is a Bash framework that provides an object-oriented-like interface for writing shell scripts, or just for working on the terminal.

In the process of developing [Prey][1] I ended up having lots of functions that were not really part of its core logic. So I decided to pack them altogether and turn it into a framework of its own.

Skull is written purely in Bash and doesn't have any special requirements. Just drop, include and use.

Why?
--------

Bash is awesome for many many things, but some tasks can be quite a pain to accomplish. Unlike most of the stuff you can do in Ruby/Python/etc by calling a method on an object, shell scripts usually require you to pipe here and back again -- which is not bad a bad thing, anyway --, like when you try to getting your system's IP address from ifconfig.

Besides, there is usually stuff that works differently in Mac than Linux, mostly because of the difference between the GNU and BSD variants of commands. And don't get me started on Windows. :)

Skull provides a unified interface for working with strings, arrays, hashes, processes, etc in Bash. You can also "instantiate" objects and work with them using an "object-like" interface.

Bash's syntax shares a couple of things with Ruby's, so I figured it wouldn't be too hard to make it look even closer. Take a look below.

Code
----

In Ruby you could work with an array like this:

    >> a = Array.new
    >> a.push 'foo'
    >> a.count # => 1

Skull allows you to do pretty much the same, only without Ruby. Just plain ol' Bash.

    $ Array.new a
    $ a.push 'foo'
    $ a.count # => 1
    $ a.push 'bar'
    $ a.find 'bar' # => 1 (second element)

Besides Array, there is Hash, String, Numeric, File and some other classes.

    $ Hash.new h
    $ h.store 'john' 'lennon'
    $ h.get 'john' # => 'lennon'
    $ h.all | while read key val; do echo "${key} -> ${val}"; done # 'john -> lennon'

You can also just call methods "publicly", passing the element as an argument:

    $ String.downcase "THIS ROCKS" # => "this rocks"
    $ Process.kill 22674
    $ File.size '/path/to/file.txt'

Yes sir, this *is* Bash.

How it works
------------

Skull uses aliases as a way to attach "instance methods" to objects. So what Array.new is actually doing is associating a set of aliases and functions -- as declared by the Array "class" -- to the element passed.

Skull *does* use eval here and there and I know it's pretty ugly. Unfortunately that's the only way (AFAIK) that dynamic method associations can be done in Bash. If you know a better way I'd love to hear about it.

How to use
----------

Get a tarball or clone the repo:

    $ git clone https://github.com/tomas/skull.git

If you want to use Skull in a script, just source the init script.

    #!/bin/bash
    . "/path/to/skull/init"
    (your code)

Or use it directly from the command line. You can put in your ~/.bashrc and you'll have Skull 24/7.

    . "/path/to/skull/init"

Now you can start playing around!

    String.new str 'hello world'
    str.titleize # => 'Hello World'
    str.length # => 11

To get a list of available methods you can simply tab your way around or do:

    str.methods # => capitalize contains downcase decrypt encrypt length (...)

Other useful stuff includes aliases, an Xml node parser or the System functions:

    System.os # => linux
    System.os.version # => 10.10
    System.arch # => x64
    System.logged_user # => god

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
