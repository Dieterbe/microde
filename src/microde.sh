#!/bin/sh
# this process must keep running as long as we want to use X !

# callback functions which you can override in microde settings:
# note that they can be called multiple times so make your checks
post_ssh_keys () {
        true
}
post_ssh_tunnels () {
        true
}
pre_wm () {
        true
}

# library
source /usr/lib/microde/functions.sh

# load config & launch things the user configured
if [ -n "$XDG_CONFIG_HOME" ]
then
	cfg=$XDG_CONFIG_HOME/mde/main
else
	cfg=$HOME/.config/mde/main
fi
source $cfg || echo "could not source config" >&2
microde-ssh-keys.sh
microde-ssh-tunnels.sh >/dev/null &
echo 'xecuting pre_wm'
pre_wm
echo "executing wm $WM"
$WM
