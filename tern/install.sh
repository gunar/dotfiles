#!/bin/sh
sudo pacman -Syy community/yarn
yarn global add tern
ln -fs "$(readlink -f tern-config)" ~/.tern-config
