#!/bin/bash

DEST=/opt/vrpn-deploy
AUTOUSER=restartvrpn

here=$( pwd )
tdir=$( mktemp -d )
trap 'return_here' EXIT
return_here () {
    cd "$here"
    [ -d "$tdir" ] && (echo "Removing temporary build directory"; rm -rf "$tdir")
}


cd ${tdir} && \
	cmake ${here} -DCMAKE_INSTALL_PREFIX=${DEST} \
	&& make \
	&& make install \
	&& echo "Copying upstart scripts..." \
	&& cp ${DEST}/upstart/* /etc/init/ \
	&& echo "Replacing authorized_keys file" \
	&& cat ${DEST}/ssh/authorized_keys | sudo -u ${AUTOUSER} tee /home/${AUTOUSER}/.ssh/authorized_keys > /dev/null \
	&& echo "Success! Calling restart-all-servers as ${AUTOUSER}." \
	&& sudo -u ${AUTOUSER} ${DEST}/bin/restart-all-servers
