#!/bin/sh
mkdir -p ~/.config
ln -fs "$(readlink -f .)" ~/.config/
