#!/usr/bin/env sh
. "/home/gcg/.keychain/zeno-sh"
# The DeadMansSnitch alert is disabled until the next day if either of these commands work
rsync -vrtuv /home/gcg/Passwords.kdbx root@dev.gunar.uk:/root/www/Passwords.kdbx && curl https://nosnch.in/17f8b5fc90
rsync -vrtuv root@dev.gunar.uk:/root/www/Passwords.kdbx /home/gcg/Passwords.kdbx && curl https://nosnch.in/17f8b5fc90
