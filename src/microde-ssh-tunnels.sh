#!/bin/sh
# goals:
# * have somewhat more secure, flexible network traffic: if you're at an untrusted location, you can tunnel to a trusted host and have your traffic go untunneled from there.
#   e.g. cleartext http traffic: ssh tunnel from public hotspot to home, from home have normal http traffic to site.
# * everything in userspace.  no things that affect the root space (such as openvpn with global interfaces, files in /etc, etc)
# TODO: would it be better to make 1 ssh command with all portmaps/socks stuff in it?
# NOTE: not transparant for apps without socks support. mail accounts point to localhost, same for svn checkouts
# TODO: find an elegant way to kill other ssh tunnels occupying the same port. (to bad something like "killall 'ssh -fND localhost:21222'" doesn't work, tags like 'ssh.. #localhost' also don't work i think.
# more notes from http://bbs.archlinux.org/viewtopic.php?id=70468
	
# setup tunnels to trusted endpoints. if the endpoint is listed in your known hosts, and we can connect to it, you have a secure route to send your insecure traffic over.
source /usr/lib/microde/functions.sh
source $HOME/.config/mde/main
echo "Setting up ssh tunnels.."
for host in "${TRUSTED_ENDPOINTS[@]}"
do
	for tunnel in "${SSH_TUNNELS[@]}"
	do
		# TODO: if you cannot setup tunnel because addr is already in use, then ssh process should exit too
		# TODO: if tunnel is already setup by host A, you don't need to try setting up with B anymore
		echo "-> ssh $tunnel $host"
		# parrallelize requests as much as possible..
		ssh -o ConnectTimeout=5 $tunnel $host &
	done
	sleep 5 # .. but make sure the order is respected (ie each trusted host gets a decent chance)
done
post_ssh_tunnels