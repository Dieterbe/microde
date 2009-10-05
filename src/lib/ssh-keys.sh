#!/bin/sh
# note : these scripts support invocations from in X or outside
# so you can also use these from .bash_profile to do your ssh tunnel stuff on a tty
source /usr/lib/microde/functions.sh
source $HOME/.config/mde/main 2>/dev/null
list=
for key in $LOAD_SSH_KEYS
do
	keyfile=$HOME/.ssh/$key
	if ! ssh-add -l | cut -d ' ' -f 3 | grep -q "^$keyfile\$"
	then
		list="$list $keyfile"
	fi
done

# TODO: implement decently
# in console : usually $? 1 or maybe tty1
# in X: always $? afaik
# running in console
#[[ $(tty) =~ /dev/tty* || $? -eq 1 ]] &&
echo "list $list"
if [ -n "$list" ]
then
	running xinit || ssh-add $list
	#running in X
	#[[ $(tty) =~ /dev/pts/* ]] && 
	running xinit && nohup ssh-add $list >/dev/null
fi
post_ssh_keys &
