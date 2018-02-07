#!/bin/sh
sudo pacman -Syy community/tmux
ln -fs "$(readlink -f tmux.conf)" ~/.tmux.conf
ln -fs "$(readlink -f .)" ~/.tmux
