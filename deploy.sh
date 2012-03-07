#!/bin/bash

DEST=/opt/vrpn-deploy
AUTOUSER=restartvrpn

here=$( pwd )
tdir=$( mktemp -d )
trap 'return_here' EXIT
return_here () {
    cd "$here"
    [ -d "$tdir" ] && rm -rf "$tdir"
}


cd ${tdir} && \
	cmake ${here} -DCMAKE_INSTALL_PREFIX=${DEST} \
	&& make \
	&& make install \
	&& cp ${DEST}/upstart/* /etc/init/ \
	&& cp ${DEST}/ssh/authorized_keys ~${AUTOUSER}/.ssh/authorized_keys
