#!/bin/sh
sudo ln -fs "$(readlink -f thinkfan.conf)" /etc/thinkfan.conf
systemctl --user daemon-reload
sudo systemctl daemon-reload
sudo sudo systemctl enable "$(readlink -f thinkfan.service)"
sudo sudo systemctl start thinkfan
