#!/bin/sh
yay --noconfirm -Syy thinkfan
# sudo ln -fs "$(readlink -f thinkfan.conf)" /etc/thinkfan.conf
sudo cp thinkfan.conf /etc/thinkfan.conf
# start thinkfan as soon as thermal sensor is available
sudo cp thinkfan.rules /etc/udev/rules.d/thinkfan.rules
sudo udevadm control --reload

sudo systemctl daemon-reload
sudo systemctl start thinkfan
