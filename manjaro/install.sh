#!/bin/sh
sudo ln -fs "$(readlink -f xinitrc)" ~/.xinitrc

# timesync
timedatectl set-ntp true

# cgroups
#sudo ln -sf "$(readlink -f cgconfig.conf)" /etc/cgconfig.conf
#sudo ln -sf "$(readlink -f cgrules.conf)" /etc/cgrules.conf
#sudo systemctl start cgconfig
#sudo systemctl enable cgconfig
#sudo systemctl start cgrules
#sudo systemctl enable cgrules

# redshift
sudo pacman -Syy community/redshift
sudo ln -fs "$(readlink -f redshift.service)" /etc/systemd/system/redshift.service
sudo ln -fs "$(readlink -f redshift.conf)" ~/.config/redshift.conf
sudo systemctl start redshift
sudo systemctl enable redshift

#packages
sudo pacman -Syy fasd yaourt zip extra/unzip community/tldr extra/keychain extra/lxsession upower community/the_silver_searcher extra/imagemagick community/fzf extra/alsa-utils extra/pavucontrol extra/xorg-xinput community/npm community/xautolock openssh net-tools extra/python-pip extra/python2-pip extra/graphviz extra/gnu-netcat extra/vlc ruby qt4 xdot aria2 aria2 xf86-video-fbdev

yaourt -Syy aur/vlock-original  community/xlockmore aur/nvm
