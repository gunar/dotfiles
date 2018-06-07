#!/bin/sh
sudo pacman -Syy community/redshift
sudo ln -fs "$(readlink -f redshift.conf)" ~/.config/redshift.conf
systemctl --user daemon-reload
systemctl --user start redshift
systemctl --user enable redshift
