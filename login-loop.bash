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
	echo "Ein normaler Benutzername ist dein Vor- und Nachname, zusammen und klein geschrieben, mit ausgeschriebenen Umlauten (ae, ue, oe)."
	echo "Wenn du noch kein Benutzerkonto hast oder es ein anderes Probleme gibt, komm zu den Servicezeiten in den Pool oder schreibe uns eine Email:"
	echo "studpool-admins.physik@lists.tu-dortmund.de"

	
	echo ""
	
	echo -n "Enter druecken, um sich anzumelden oder d, um eine Benutzeroberflaeche zu waehlen "
	read -n1 de

	if [ "$de" -eq "d" ]
	then
		echo -n "Xfce (x), Gnome (g), Mate (m): "
		read -n1 de
		
		case $de in
			g)
			de="gnome-session"
			;;
			x)
			de="xfce4-session"
			*)
			echo "Keine gueltige angabe, benutzte xfce."
			de="xfce4-session"
		esac
	else
		de="xfce4-session"
	fi

	echo -n "Username: "
	read username
	echo -n "Password: "
	read -s password

	echo ""
	echo "Einloggen..."
	
	# termite is used to display login console. One termite instance produces two window handles, only the last one is usabel.
	WID=$(xdotool search --class termite | tail -n1)
	xdotool windowunmap --sync $WID #hides terminal used to login from X
	(sshpass -p "$password" ssh -YC -l "$username" "$server" $de)
	returncode=$?
	#sshpass -p "$password" ssh -Y -q -l "$username" $server xfce4-session
	xdotool windowmap --sync $WID #let login terminal re-appear
	xdotool windowfocus --sync $WID

	
	if [ "$returncode" -ne "0" ]
	then
		echo "Einloggen gescheitert. Ist vielleicht das Passwort oder der Benutzername falsch?"
		sleep 5
	fi
done
