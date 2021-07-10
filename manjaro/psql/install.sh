#!/bin/sh
set -xe
sudo ln -fs "$(readlink -f psqlrc)" ~/.psqlrc
sudo ln -fs "$(readlink -f pgclirc)" ~/.config/pgcli/config
