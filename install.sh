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

echo -n "Inbox.lv username: "
read INBOXLV_USERNAME
echo -n "Inbox.lv password: "
read INBOXLV_PASSWORD

sed -r "s#t4Rp07#$INBOXLV_USERNAME;s#p455w0rd#$INBOXLV_PASSWORD"
