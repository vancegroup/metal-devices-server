#!/bin/sh
VRPN_UPSTART="/etc/init/vrpn.conf"
sudo touch ${VRPN_UPSTART}
sudo chgrp ${USER} ${VRPN_UPSTART}
sudo chmod g+w ${VRPN_UPSTART}
