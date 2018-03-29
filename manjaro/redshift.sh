#!/bin/sh
sudo pacman -Syy community/redshift
sudo sudo systemctl enable "$(readlink -f redshift.service)"
sudo ln -fs "$(readlink -f redshift.conf)" ~/.config/redshift.conf
systemctl --user daemon-reload
sudo systemctl daemon-reload
sudo systemctl start redshift
sudo systemctl enable redshift
