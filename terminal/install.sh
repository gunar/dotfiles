#!/bin/sh
sudo pacman -Syy alacritty
mkdir -p ~/.config/alacritty
ln -fs "$(readlink -f alacritty.yml)" ~/.config/alacritty/alacritty.yml
