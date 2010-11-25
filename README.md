Skull
======

Skull is a Bash framework that provides an object-oriented-like layer for writing shell scripts, or just for working on the terminal.

Most of the stuff was taken out of [Prey][1], but since there's lots of useful functions, I decided to turn it into a framework on its own. Skull is written purely in Bash and doesn't have any special requirements. Just drop, include and use.

Overview
--------

Bash is awesome for many things, but doesn't have any way of working with objects. In fact, most of the stuff you normally do in Ruby/Python/etc is simply a method call, but normally in shell scripts you need to pipe a command into another and another, and perhaps another one too -- e.g. getting your IP address from ifconfig.

Besides, there is usually stuff that works differently in Mac than Linux, mostly because of the difference between the GNU and BSD variants of commands. And don't get me started on Windows. :)

Skull provides a unified interface for working with strings, arrays, hashes, processes, etc in Bash. You can also "instantiate" objects and work with them using an "object-like" interface.

Bash's syntax is actually quite similar to Ruby, so I figured it wouldn't be too hard to make Bash become more ruby-like. Take a look below.

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

You can also just call methods "publicly", passing the element as an argument:

    $ String.downcase "THIS ROCKS" # => "this rocks"
    $ Process.kill 22674
    $ File.size '/path/to/file.txt'

Yes, this *is* Bash. Trust me.

How it works
------------

Skull uses aliases as a way to attach "instance methods" to objects. So what Array.new is actually doing is associating a set of aliases and functions -- as declared by the Array "class" -- to the element passed.

Skull *does* use eval here and there and yes, I know it's kind of ugly, but that's the only way (AFAIK) that dynamic method associations can be done. If you know a better way I'd love to hear about it.

How to use
----------

Get a tarball or clone the repo:

    $ git clone https://github.com/tomas/skull.git

If you want to use Skull in a script, just source the init script.

    #!/bin/bash
    . "/path/to/skull/init"
    (your code)

Or directly from the command line. You can put in your ~/.bashrc and you'll have Skull 24/7.

    . "/path/to/skull/init"

Now you can start playing around!

    String.new str 'hello world'
    str.titleize # => 'Hello World'
    str.length # => 11

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
