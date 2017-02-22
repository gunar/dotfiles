#!/bin/sh
sudo ln -sf "$(readlink -f cgconfig.conf)" /etc/cgconfig.conf
sudo ln -sf "$(readlink -f cgrules.conf)" /etc/cgrules.conf
sudo systemctl start cgconfig
sudo systemctl enable cgconfig
sudo systemctl start cgrules
sudo systemctl enable cgrules
