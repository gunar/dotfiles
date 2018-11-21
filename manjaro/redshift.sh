#!/bin/sh
sudo pacman -Syy community/redshift
sudo ln -fs "$(readlink -f redshift.conf)" ~/.config/redshift.conf
# Now add this to /usr/lib/systemd/user/redshift.service
# [Service]
# Environment=DISPLAY=:0
systemctl --user daemon-reload
systemctl --user start redshift
systemctl --user enable redshift
