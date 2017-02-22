#!/bin/sh
mkdir -p ~/.config/termite
ln -fs "$(readlink -f termite.conf)" ~/.config/termite/config
