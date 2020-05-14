#!/bin/sh
sudo ln -fs "$(readlink -f emacsclient.desktop)" ~/.local/share/applications
xdg-mime default emacsclient.desktop x-scheme-handler/org-
sudo update-desktop-database
