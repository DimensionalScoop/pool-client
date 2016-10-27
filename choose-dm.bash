echo -n "Enter drücken, um sich anzumelden oder d, um eine Benutzeroberfläche zu wählen "
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