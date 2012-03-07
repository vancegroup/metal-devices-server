#!/bin/bash
AUTOUSER=restartvrpn
function impersonate() {
	sudo -u ${AUTOUSER} $@
}

[ -d /home/${AUTOUSER}/.ssh ] || impersonate mkdir -p /home/${AUTOUSER}/.ssh
impersonate touch /home/${AUTOUSER}/.ssh/authorized_keys
sudo chgrp ${USER} /home/${AUTOUSER}/.ssh /home/${AUTOUSER}/.ssh/authorized_keys
sudo chmod g+rw /home/${AUTOUSER}/.ssh/authorized_keys
sudo chmod g+rx /home/${AUTOUSER}/.ssh
