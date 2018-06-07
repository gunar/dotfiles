#!/bin/sh
yaourt --noconfirm -Syy thinkfan
# sudo ln -fs "$(readlink -f thinkfan.conf)" /etc/thinkfan.conf
sudo cp thinkfan.conf /etc/thinkfan.conf
# start thinkfan as soon as thermal sensor is available
sudo ln -fs "$(readlink -f thinkfan.rules)" /etc/udev/rules.d/thinkfan.rules
udevadm control --reload

sudo systemctl daemon-reload
sudo systemctl start thinkfan
