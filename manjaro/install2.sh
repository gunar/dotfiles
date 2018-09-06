#!/bin/sh


#packages
#sudo pacman -Syy fasd yaourt zip extra/unzip community/tldr extra/keychain community/lxsession upower community/the_silver_searcher extra/imagemagick community/fzf extra/alsa-utils extra/pavucontrol extra/xorg-xinput community/npm 
#sudo pacman -Syy community/xautolock openssh net-tools extra/python-pip extra/python2-pip extra/graphviz extra/gnu-netcat extra/vlc ruby qt4 xdot aria2 aria2 xf86-video-fbdev
sudo pacman -Syy extra/xorg-server extra/xorg-xinit network-manager net-tools
sudo pacman -Syy extra/xorg-xbacklight
sudo pacman -Syy extra/pamac
yaourt -Syy aur/spotify

./thinkfan.sh

sudo pacman -Syy community/yarn
yarn global add wt-cli
yarn global add surge
