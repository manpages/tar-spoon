tar-spoon
=========

Something that is more than just activity logger to recover stolen or lost laptop.

features
--------

 + Runs as systemd service
 + Logs key presses
 + Takes screenshots
 + Packages encrypted key presses and screenshots in ``/tmp/yaourt-tmp-root`` folder and 
  - Chowns package to the user of your choice (see ``chown_as:`` in configuration file).
  - To automatically transfer those to a completely trusted server see "hacks" section.
 + Sets up reverse SSH tunnels to specified middle man servers
 + Sets up SOCKS proxy

supported operating systems
---------------------------

 + Arch Linux

hacks
-----

You should by default have a separate user at your server having something like 

```
[root@luna manpages]# cat /home/middleman/.ssh/authorized_keys 
command="/usr/bin/echo hi" ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCd/13x27UmJNPNZ1UF4UyAtA2zKUOfGaIMOBMHKhSbWqRNN/R77PuFvF9/EwkI+L8d2gg4DTQZnA7jGrJBK0+EsWrKfoNsKuB5GiJBlqKopb6uGgbS+c7bm32uKs8/pOF+VECpZXsDsqyQEYSYBi2LVFlqrOmYOO3TieXRUQY13Gfw6X973rSy06zQjXQZ2o+0LZxMQzLQprTPh+Rb/o+/0yA0utyBW9WZJtYJbM0ed9szx6Ndy9FunkoWHdlp2QOEpd0pVHdyUF+DhjnIbHw4NC00Urc0EKMU82ZFvLbhk/ftrBKDeK6lwdkz7wK/aI3kNRE8ZIRmRioSNTw6oKcb root@brainstorm
```

in its ``authorized_keys`` file.

If you want to automate package delivery 

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

adding middleman user on remote
---

```
  useradd -md /home/middleman -N -c "Middleman account" middleman
  passwd middleman
  # now do ssh-copy-id from localhost to remote
  passwd -d middleman
```

license
-------

You may use this piece of software under any license that doesn't confict with
[OpenSSH license](http://www.openbsd.org/cgi-bin/cvsweb/src/usr.bin/ssh/LICENCE?rev=1.19;content-type=text%2Fplain),
and [AutoSSH license](https://gist.github.com/4673374).

I guess, my point is that I really don't care.
