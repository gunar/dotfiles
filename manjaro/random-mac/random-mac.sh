#!/usr/bin/env bash

# Docs: https://man.archlinux.org/man/NetworkManager.8.en

# XXX: This file is a copy. Please edit the original one in dotfiles/manjaro/random-mac/random-mac.sh then copy it to /etc/NetworkManager/dispatcher.d/pre-up.d/random-mac.sh

set -xe

# Log for debugging
exec 3>&1 1>/tmp/random-mac.log 2>&1

if [[ "$DEVICE_IFACE" == "wlp4s0" ]]; then
  ifconfig "$DEVICE_IFACE" down
  ifconfig "$DEVICE_IFACE" hw ether "$(hexdump -n 6 -ve '1/1 "%.2x "' /dev/random | awk -v a="2,6,a,e" -v r="$RANDOM" 'BEGIN{srand(r);}NR==1{split(a,b,",");r=int(rand()*4+1);printf "%s%s:%s:%s:%s:%s:%s\n",substr($1,0,1),b[r],$2,$3,$4,$5,$6}')"
  ifconfig "$DEVICE_IFACE" up
fi

