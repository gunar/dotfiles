#!/usr/bin/env sh
source "/home/gcg/.keychain/zeno-sh"
rsync -vrtuv /home/gcg/Passwords.kdbx root@besloor.com:/root/www/Passwords.kdbx
rsync -vrtuv root@besloor.com:/root/www/Passwords.kdbx /home/gcg/Passwords.kdbx
