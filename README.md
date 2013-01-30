tar-spoon
=========

Something that is more than just activity logger to recover stolen or lost laptop.

features
--------

 + Runs as systemd service
 + Logs key presses
 + Takes screenshots
 + Sends encrypted key presses and screenshots over email
 + Sets up reverse SSH tunnels to specified middle man servers
 + Sets up SOCKS proxy

supported operating systems
---------------------------

 + Arch Linux

todo
----

 + Refactor tarspoon in form of a PKGBUILD because that's what it essentially is
  - Publish refactored PKGBUILD in AUR
 + Add support for Ubuntu
 + Add support for Mac OS X
 + Automate GPG key generation
  - Automate GPG key delivery to remote keyring
 + Advanced configuration for tarspoon feature set

logkeys todo
------------

 + Fork it
  - Add sane USB-keyboard support

license
-------

You may use this piece of software under any license that doesn't confict with
[OpenSSH license](http://www.openbsd.org/cgi-bin/cvsweb/src/usr.bin/ssh/LICENCE?rev=1.19;content-type=text%2Fplain),
and [AutoSSH license](https://gist.github.com/4673374).

I guess, my point is that I really don't care.
