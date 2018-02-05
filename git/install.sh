#!/bin/sh
ln -fs "$(readlink -f gitconfig)" ~/.gitconfig
ln -fs "$(readlink -f git-templates)" ~/.git-templates
