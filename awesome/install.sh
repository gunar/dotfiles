#!/bin/sh
mkdir -p ~/.config
ln -fs "$(readlink -f .)" ~/.config/
ln -fs "$(readlink -f xinitrc)" ~/.xinitrc
