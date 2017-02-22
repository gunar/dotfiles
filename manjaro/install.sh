#!/bin/sh

# cgroups
sudo ln -sf "$(readlink -f cgconfig.conf)" /etc/cgconfig.conf
sudo ln -sf "$(readlink -f cgrules.conf)" /etc/cgrules.conf
sudo systemctl start cgconfig
sudo systemctl enable cgconfig
sudo systemctl start cgrules
sudo systemctl enable cgrules

# xflux
sudo ln -fs "$(readlink -f auto-xflux.service)" /etc/systemd/system/auto-xflux.service
sudo systemctl start auto-xflux
sudo systemctl enable auto-xflux
