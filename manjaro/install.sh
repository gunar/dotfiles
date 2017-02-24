#!/bin/sh

# cgroups
sudo ln -sf "$(readlink -f cgconfig.conf)" /etc/cgconfig.conf
sudo ln -sf "$(readlink -f cgrules.conf)" /etc/cgrules.conf
sudo systemctl start cgconfig
sudo systemctl enable cgconfig
sudo systemctl start cgrules
sudo systemctl enable cgrules

# redshift
sudo ln -fs "$(readlink -f redshift.service)" /etc/systemd/system/redshift.service
sudo ln -fs "$(readlink -f redshift.conf)" ~/.config/redshift.conf
sudo systemctl start redshift
sudo systemctl enable redshift
