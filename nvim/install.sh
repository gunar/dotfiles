#!/bin/sh
mkdir -p ~/.config/nvim
ln -fs "$(readlink -f nvim.vim)" ~/.config/nvim/init.vim
ln -fs "$(readlink -f settings)" ~/.config/nvim/settings
