#!/bin/bash

DEST=/opt/vrpn-deploy
AUTOUSER=restartvrpn

log () {
	logger -t "device-server" "deploy.sh: $1"
}

here=$( pwd )
tdir=$( mktemp -d )
log "created temporary build directory ${tdir}.";

trap 'return_here' EXIT
return_here () {
    cd "$here"
    [ -d "$tdir" ] && (log "deploy.sh: Removing temporary build directory ${tdir}."; echo "Removing temporary build directory"; rm -rf "$tdir")
}


cd ${tdir} \
	&& log "beginning configure, will install to ${DEST}" \
	&& cmake ${here} -DCMAKE_INSTALL_PREFIX=${DEST} \
	&& log "beginning make" \
	&& make \
	&& log "beginning make install" \
	&& make install \
	&& echo "************" \
	&& log "copying upstart scripts" \
	&& echo "Copying upstart scripts..." \
	&& cp ${DEST}/upstart/* /etc/init/ \
	&& log "replacing /home/${AUTOUSER}/.ssh/authorized_keys with ${DEST}/ssh/authorized_keys" \
	&& echo "Replacing authorized_keys file" \
	&& cat ${DEST}/ssh/authorized_keys | sudo -u ${AUTOUSER} tee /home/${AUTOUSER}/.ssh/authorized_keys > /dev/null \
	&& log " Success! Calling restart-all-servers as ${AUTOUSER}." \
	&& echo "Success! Calling restart-all-servers as ${AUTOUSER}." \
	&& env SSH_ORIGINAL_COMMAND="post-deploy" sudo -u ${AUTOUSER} ${DEST}/bin/restart-all-servers
