#!/bin/bash

server="stud.physik.tu-dortmund.de"

trap '' 2 # ignore Ctrl+C


while [ True ]
do
	clear
	echo "Studpool Arch Server"
	
	(ping -c1 $server >> /dev/null)
	if [ "$?" -ne "0" ]
	then
		echo "Server ist offline"
	else
		echo "Server online"
	fi

	echo ""
	cat "greeting-message"
	echo ""
	
	#bash "choose-dm.bash"
	de="xfce4-session"

	echo -n "Username: "
	read username
	echo -n "Password: "
	read -s password

	echo ""
	echo "Einloggen..."
	
	# termite is used to display login console. One termite instance produces two window handles, only the last one is usabel.
	WID=$(xdotool search --class termite | tail -n1)
	xdotool windowunmap --sync $WID # hides terminal used to login from X

	(sshpass -p "$password" ssh -YC -l "$username" "$server" $de) # -C compresses stream, seems to work faster than sending uncompressed stream
	returncode=$?

	xdotool windowmap --sync $WID # let login terminal re-appear
	xdotool windowfocus --sync $WID

	
	if [ "$returncode" -ne "0" ]
	then
		echo "Einloggen gescheitert. Ist vielleicht das Passwort oder der Benutzername falsch?"
		sleep 5
	fi
done
