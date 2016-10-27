System auto-login on tty1 to user 'pool'
bash reads /home/pool/.bash_profile and starts xinit
xinit reads .xinitrc and starts termite and executes get-login-script.bash
get-login-script.bash pulls most current scripts from github and starts main.bash
main.bash prompts user to enter username, password and then ssh to stud server, running xfce4-session