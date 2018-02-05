#!/bin/sh
meld $2 $1 &
meld $1 $3 &
# meld $2 $4 $3
meld $2 $1 $3
