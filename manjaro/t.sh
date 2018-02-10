#!/bin/sh

sudo pacman -Syy community/redshift
sudo ln -fs "$(readlink -f redshift.service)" /etc/systemd/system/redshift.service
sudo ln -fs "$(readlink -f redshift.conf)" ~/.config/redshift.conf
sudo systemctl daemon-reload
sudo systemctl start redshift
sudo systemctl enable redshift
