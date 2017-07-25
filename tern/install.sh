#!/bin/sh
yarn global add tern
ln -fs "$(readlink -f tern-config)" ~/.tern-config
