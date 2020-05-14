#!/bin/sh
# Source https://github.com/stove-panini/fontconfig-emoji
sudo rm /etc/fonts/conf.d/75-joypixels.conf | true
sudo ln -fs "$(readlink -f 69-emoji-monospace.conf)" /etc/fonts/conf.d/69-emoji-monospace.conf
sudo ln -fs "$(readlink -f 69-emoji.conf)" /etc/fonts/conf.d/69-emoji.conf
sudo ln -fs "$(readlink -f 70-no-dejavu.conf)" /etc/fonts/conf.d/70-no-dejavu.conf
sudo ln -fs "$(readlink -f 70-no-mozilla-emoji.conf)" /etc/fonts/conf.d/70-no-mozilla-emoji.conf
