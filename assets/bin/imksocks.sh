function no_host {
	echo "No host given, aborting. You may later run 
	  sudo /path/to/tarspoon/assets/bin/imksocks.sh
	to configure SOCKS proxy." && exit
}
r_ssh_port=22
k_path=~/.ssh/id_rsa
l_socks_port=$1
r_user=$SUDO_USER

echo "Creating socks proxy on 127.0.0.1:${l_socks_port}..."
echo

echo "Remote IP or hostname (better use IP here):"
read r_host
[[ ! -z $r_host ]] || no_host 
echo "Remote SSH port [$r_ssh_port]:"
read r_ssh_port1
[[ ! -z $r_ssh_port1 ]] && r_ssh_port=$r_ssh_port1

echo "Path to SSH key [$k_path]:"
read k_path1
[[ ! -z $k_path1 ]] && k_path=$k_path1

echo "Remote user [$r_user]:"
read r_user1
[[ ! -z $r_user1 ]] && r_user=$r_user1

mksocks $r_user $r_host $k_path $r_ssh_port $l_socks_port

echo "SOCKS proxy configured. That was a triumph."
