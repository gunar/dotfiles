#!/bin/sh
sudo pacman -Syy community/termite
mkdir -p ~/.config/termite
ln -fs "$(readlink -f termite.conf)" ~/.config/termite/config
