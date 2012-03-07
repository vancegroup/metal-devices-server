#!/bin/sh
VRPN_UPSTART="/etc/init/vrpn.conf /etc/init/vrpn-leftglove.conf /etc/init/vrpn-rightglove.conf"
sudo touch ${VRPN_UPSTART}
sudo chgrp ${USER} ${VRPN_UPSTART}
sudo chmod g+w ${VRPN_UPSTART}
