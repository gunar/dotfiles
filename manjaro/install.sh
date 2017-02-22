#!/bin/sh
sudo ln -sf "$(readlink -f cgconfig.conf)" /etc/cgconfig.conf
sudo ln -sf "$(readlink -f cgrules.conf)" /etc/cgrules.conf
