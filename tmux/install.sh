#!/bin/sh
ln -fs "$(readlink -f tmux.conf)" ~/.tmux.conf
ln -fs "$(readlink -f .)" ~/.tmux
