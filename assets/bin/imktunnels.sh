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
	local m_ssh_port=22
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

	errcho "Middleman port to connect to this machine: [$m_port]"
	read m_port1
	[[ ! -z m_port1 ]] && m_port=$m_port1

	errcho "Middleman SSH port: [$m_ssh_port]"
	read m_ssh_port1
	[[ ! -z $m_ssh_port1 ]] && m_ssh_port=$m_ssh_port1

	errcho "Let's try to copy the public key over..."
	su -c "ssh-copy-id -p $m_ssh_port -i $key_path $middleman@$kitty" root >/dev/null 2>/dev/null
	
  mktunnel $tun $middleman $kitty $key_path $m_ssh_port $m_port $prefix $suffix  

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
