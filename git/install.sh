#!/bin/sh
sudo pacman -Syy community/diff-so-fancy
ln -fs "$(readlink -f gitconfig)" ~/.gitconfig
ln -fs "$(readlink -f git-templates)" ~/.git-templates
