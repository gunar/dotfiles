#!/bin/sh
yay -Syy aur/zoom aur/ngrok
sudo pacman -Syy extra/xorg-xclipboard extra/xclip
(cd awesome;./install.sh)
(cd git;./install.sh)
(cd manjaro;./install.sh)
(cd node;./install.sh)
(cd nvim;./install.sh)
(cd scripts;./install.sh)
(cd termite;./install.sh)
(cd tmux;./install.sh)
(cd zsh;./install.sh)
(cd tern;./install.sh)
