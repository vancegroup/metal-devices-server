#!/bin/sh
echo "Setting permissions for $1"
sudo mkdir -p $1
sudo chgrp -R ${USER} $1
sudo chmod -R g+w $1