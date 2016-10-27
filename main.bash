#!/bin/bash

# server needs to kill sshd: user@notty on logout

server="stud.physik.tu-dortmund.de"

trap '' 2 # ignore Ctrl+C


echo "Maintainance"
sleep 1
exit

while [ True ]
do
	clear
	echo "Studpool Arch Server"
	echo "Client v1.0"
	
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
	de="mate-session" #"xfce4-session"
	startup="bash /opt/poolscripts/run-on-pool-client-login.sh" # run script on login
	ssh_options='-o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no' # remove as soon as only new sever runs

	echo -n "Username: "
	read username

	echo -n "Password: "
	read -s password

	echo ""
	echo "Einloggen..."
	
	# termite is used to display login console. One termite instance produces two window handles, only the last one is usabel.
	WID=$(xdotool search --class termite | tail -n1)
	xdotool windowunmap --sync $WID # hides terminal used to login from X

	(sshpass -p "$password" ssh $ssh_options -YC -l "$username" "$server" "$startup & $de") # -C compresses stream, seems to work faster than sending uncompressed stream
	returncode=$?

	xdotool windowmap --sync $WID # let login terminal re-appear
	xdotool windowfocus --sync $WID

	
	if [ "$returncode" -ne "0" ]
	then
		echo "Einloggen gescheitert. Ist vielleicht das Passwort oder der Benutzername falsch?"
		sleep 5
	fi
done
