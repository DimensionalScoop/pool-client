#!/bin/bash

# server needs to kill sshd: user@notty on logout

server="stud.physik.tu-dortmund.de"

mkdir ~/.x2goclient
cp sessions ~/.x2goclient/sessions

x2goclient --thinclient  --no-menu --maximize --session="Stud" --no-session-edit --add-to-known-hosts --close-disconnect