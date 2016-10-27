#!/bin/bash

source_server="https://github.com/DimensionalScoop/"
repo="pool-client"
script="main.bash"

git clone "$source_server$repo" #try to clone
if [ "$?" -ne "0" ]
	then #local copy of repo probably already exists
	cd $repo
	git reset --hard
	git pull
	cd ..
fi

cd $repo
#bash $script