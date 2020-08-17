#!/bin/sh

./screenrecording/install.sh

sudo ln -fs "$(readlink -f backup/backup.service)" /etc/systemd/system/backup.service
sudo ln -fs "$(readlink -f backup/backup.timer)" /etc/systemd/system/backup.timer
sudo systemctl start backup.timer
sudo systemctl enable backup.timer

