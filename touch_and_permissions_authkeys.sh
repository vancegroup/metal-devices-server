#!/bin/bash
AUTOUSER=vrpnrestart
function impersonate() {
	sudo -U ${AUTOUSER} $@
}

impersonate mkdir -p ~${AUTOUSER}/.ssh
impersonate touch ~${AUTOUSER}/.ssh/authorized_keys
impersonate chgrp ${USER} ~${AUTOUSER}/.ssh/authorized_keys
impersonate chmod g+rw ~${AUTOUSER}/.ssh/authorized_keys
