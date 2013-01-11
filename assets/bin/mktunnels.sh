#!/bin/bash
function errcho {
	echo $1>&2
}

function mktun {
	local tun=$1
	errcho "Make a verbose log about this tunnel? [y/N] "
	read answer
	if [ "$answer" == 'y' ] ; then
		errcho "Yeah, fuck off"
	fi
}

errcho "You're about to setup reverse SSH tunnels that will be used to penetrate NAT."
errcho "  I tend to setup two tunnels — local (for testing purposes) and real-world."
errcho "  When the application is configured and tested, I just delete the local tunnel."
errcho "  But you surely can setup several middleman-servers, if you control more than one."

tunnels=$(ls /usr/local/bin | grep tun_)

if [[ ! -z $tunnels ]]; then
	errcho "  Existing tunnels: $tunnels"
	errcho "    You may delete existing tunnels simply by removing the file from /usr/local/bin/"
fi

while errcho "Enter a name for the new tunnel (to stop, press return key...)" && read TUN_NAME && [[ ! -z $TUN_NAME ]]; do
	mktun $TUN_NAME
done

echo -n "foo bar baz"
