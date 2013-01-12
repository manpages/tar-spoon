#!/bin/bash

# todo: archlinux PKGBUILD for tar-spoon
echo "Please make sure these are installed: sudo, systemd, ssmtp, logkeys, scrot, wicd, gpg"
echo "Logkeys can be found here: http://code.google.com/p/logkeys/source/checkout"
echo -n "Press enter to continue..."
read

echo "Enter dummy http://inbox.lv account name and password."
echo "  Those will be used to forward encrypted mails with laptop activity logs to your actual email"
echo "  If you don't have inbox.lv account, create one now."
echo "  It's awesome for throw-away mailboxes, as it doesn't expire and tolerates registration over Tor."
echo "  Don't forget to allow external SMTP access here:"
echo "  http://mail.inbox.lv/horde/imp/prefs.php?language=en&group=forward"

echo -n "Inbox.lv username (empty to skip that step): "
read INBOXLV_USERNAME
if [[ ! -z $INBOXLV_USERNAME ]]; then
	echo -n "Inbox.lv password: "
	read INBOXLV_PASSWORD

	echo "Backing up existing ssmtp.conf and revaliases [invoking sudo]"
	sudo mv /etc/ssmtp/ssmtp.conf /etc/ssmtp/ssmtp.conf.old 2>/dev/null
	sudo mv /etc/ssmtp/revaliases /etc/ssmtp/revaliases.old 2>/dev/null

	echo "Putting new ssmtp.conf and revaliases to /etc/ssmtp/"
	sed -r "s#t4Rp07#$INBOXLV_USERNAME#;s#p455w0rd#$INBOXLV_PASSWORD#" assets/conf/ssmtp.conf | sudo tee /etc/ssmtp/ssmtp.conf 1>/dev/null
	sed -r "s#t4Rp07#$INBOXLV_USERNAME#" assets/conf/revaliases | sudo tee /etc/ssmtp/revaliases 1>/dev/null
fi

echo "Installing reverse ssh tunnels [invoking sudo]"
for TUNNEL in `sudo assets/bin/mktunnels.sh` ; do
	echo "Tunnel: $TUNNEL"
done

sudo mkdir -p /usr/local/etc/tarspoon
sudo touch /usr/local/etc/tarspoon/receiver.name
sudo touch /usr/local/etc/tarspoon/receiver.mail
echo "Heads up! You will need to generate keypair that the program will use to transport dumped information over mail."
echo "  Import the pubkey with the ultimate trust to the local root keyring;"
echo "  Put name assigned to that keyring into /usr/local/etc/tarspoon/receiver.name;"
echo "  Target email address into /usr/local/etc/tarspoon/receiver.mail."
