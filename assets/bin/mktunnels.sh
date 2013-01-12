#!/bin/bash
function errcho {
	echo $1>&2
}

function mktun {
	local prefix="-f"
	local suffix=""
	local key_path=""
	local kitty=""
	local m_port=$[ ( $RANDOM % 10000 )  + 10000 ]
	local tun=$1

	errcho "Make a verbose log about this tunnel? [y/N] "
	read answer
	if [ "$answer" == 'y' ] ; then
		prefix="-vv"
		suffix="> /var/log/tarspoon/$tun-out.log"
	fi
	errcho "Path to the laptop --> middleman key. [~/.ssh/id_rsa]"
	read key_path
	[[ -z $key_path ]] && key_path="~/.ssh/id_rsa"

	errcho "Middleman server hostname or ip address:"
	read kitty
	[[ -z $kitty ]] && return

	errcho "Middleman username: [$SUDO_USER]"
	read middleman
	[[ -z $middleman ]] && middleman="$SUDO_USER"

	errcho "Let's try to copy the public key over..."
	su -c "ssh-copy-id -i $key_path $middleman@$kitty" root >/dev/null 2>/dev/null
	
	echo "#!/bin/bash
	export AUTOSSH_PORT=0
	export AUTOSSH_GATETIME=0
	autossh $prefix -- -o 'ControlPath none' -i $key_path -R $m_port:localhost:22 $middleman@$kitty -N $suffix 2>/var/log/tarspoon/$tun-err.log
	" > /usr/local/bin/tun_$tun

	chmod +x /usr/local/bin/tun_$tun
}

mkdir -p /var/log/tarspoon

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

ls /usr/local/bin | grep tun_
