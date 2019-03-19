#!/bin/sh
sudo ln -fs "$(readlink -f xinitrc)" ~/.xinitrc
sudo ln -fs "$(readlink -f xkb)" /usr/share/X11/xkb/symbols/gunar

sudo loginctl enable-linger "$(whoami)"

# timesync
timedatectl set-ntp true

# cgroups
#sudo ln -sf "$(readlink -f cgconfig.conf)" /etc/cgconfig.conf
#sudo ln -sf "$(readlink -f cgrules.conf)" /etc/cgrules.conf
#sudo systemctl start cgconfig
#sudo systemctl enable cgconfig
#sudo systemctl start cgrules
#sudo systemctl enable cgrules

./redshift.sh

#packages
sudo pacman -Syy fasd yaourt zip extra/unzip community/tldr extra/keychain extra/lxsession upower community/the_silver_searcher extra/imagemagick community/fzf extra/alsa-utils extra/pavucontrol extra/xorg-xinput community/npm community/xautolock openssh net-tools extra/python-pip extra/python2-pip extra/graphviz extra/gnu-netcat extra/vlc ruby qt4 xdot aria2 aria2 xf86-video-fbdev

yaourt -Syy aur/vlock-original  community/xlockmore aur/nvm
sudo pacman -Syy extra/xorg-clipboard
sudo pacman -Syy extra/xorg-xclipboard
sudo pacman -Syy xf86-video-intel
sudo pacman -Syy xf86-input-synaptics

yaourt -Syy aur/chromium-widevine
sudo pacman -Syy extra/pepper-flash
sudo pacman -Syy extra/xorg-xkill
sudo pacman -Syy extra/xfce4-screenshooter
sudo pacman -Syy xorg-xev
sudo pacman -Syy gpick
sudo pacman -Syy xorg-xdpyinfo
sudo pacman -Syy thunar
sudo pacman -Syy xss-lock
sudo pacman -Syy compton
# sudo pacman -Syy xcompmgr
sudo pacman -Syy viewnior
sudo pacman -Syy xfce4-taskmanager
sudo pacman -Syy tree
sudo pacman -Syy hub
yaourt --noconfirm -Syy shutter
sudo pacman -Syy youtube-dl
sudo pacman -Syy galculator
sudo pacman -Syy pandoc
sudo pacman -Syy libmcrypt
sudo pacman -Syy xfce4-settings
sudo pacman -Syy autofs
sudo pacman -Syy calibre
sudo pacman -Syy subdl
sudo pacman -Syy lsof
sudo pacman -Syy libva-intel-driver libvdpau-va-gl mesa lib32-mesa vulkan-intel lib32-vulkan-intel
sudo pacman -Syy libva-utils
sudo pacman -Syy vdpauinfo
sudo pacman -Syy xorg-xmodmap
yaourt --noconfirm -Syy pstate-frequency
yaourt --noconfirm -Syy fancontrol-gui
sudo pacman -Syy stress
sudo pacman -Syy namcap
sudo pacman -Syy moreutils
sudo pacman -Syy bluez bluez-utils
sudo pacman -Syy pulseaudio-bluetooth
sudo pacman -Syy bluez-libs
yaourt --noconfirm -Syy xmacro
sudo pacman -Syy extra/xorg-fonts-100dpi extra/xorg-fonts-75dpi
sudo pacman -Syy extra/xorg-fonts-misc
yaourt --noconfirm -Syy community/wmctrl
yaourt --noconfirm -Syy boot
yaourt --noconfirm -Syy bdf-creep
sudo pacman -Syy unrar
sudo pacman -Syy guvcview
sudo pacman -Syy scrot
sudo pacman -Syy i3lock
yaourt --noconfirm -Syy teamviewer
yaourt --noconfirm -Syy teamviewer
yaourt --noconfirm -Syy teamviewer12
sudo pacman -Syy iftop
yaourt --noconfirm -Syy geoclue2
sudo pacman -Syy catdoc
sudo pacman -Syy qemu-arch-extra
sudo pacman -Syy qemu
yaourt --noconfirm -Syy clover-efi
yaourt --noconfirm -Syy uml_utilities
sudo pacman -Syy arp-scan
sudo pacman -Syy libmicrodns
sudo pacman -Syy protobuf
yaourt --noconfirm -Syy castnow-git
sudo pacman -Syy minidlna
yaourt --noconfirm -Syy rnm
sudo pacman -Syy tumbler
yaourt --noconfirm -Syy autokey-py3
sudo pacman -Syy filezilla
sudo pacman -Syy inkscape
yaourt --noconfirm -Syy shutter
yaourt --noconfirm -Syy postman
yaourt --noconfirm -Syy flameshot
sudo pacman -Syy docker docker-compose
yaourt --noconfirm -Syy ttf-twemoji-color
sudo pacman -Syy mlocate
yaourt --noconfirm -Syy up
sudo pacman -Syy colordiff
yaourt --noconfirm -Syy warsaw-bin
yaourt --noconfirm -Syy ttf-emojione-color
yaourt --noconfirm -Syy ttf-emojione
yaourt --noconfirm -Syy ibus-uniemoji
sudo pacman -Syy ibus
sudo pacman -Syy ibus-qt
sudo pacman -Syy anki
sudo pacman -Syy pgadmin4
sudo pacman -Syy tor
yaourt --noconfirm -Syy tor-browser
sudo pacman -Syy shellcheck
yaourt --noconfirm -Syy ladspa-bs2b
yaourt --noconfirm -Syy parcel-bundler
sudo pacman -Syy fish
yaourt --noconfirm -Syy debtap
yaourt --noconfirm -Syy bat
sudo pacman -Syy siege
sudo pacman -Syy shellcheck
sudo pacman -Syy mps-youtube
sudo pacman -Syy exa
sudo pacman -Syy jq
yaourt --noconfirm -Syy jiq
sudo pacman -Syy httpie
yaourt --noconfirm -Syy lsix
yaourt --noconfirm -Syy android-studio
yaourt --noconfirm -Syy mysql-clients
yaourt --noconfirm -Syy lighttable-bin
yaourt --noconfirm -Syy pgcli
sudo pacman -Syy beep
sudo pacman -Syy mpg123
yaourt --noconfirm -Syy clojure
yaourt --noconfirm -Syy planck
yaourt --noconfirm -Syy parsec-bin
sudo pacman -Syy vinagre
yaourt --noconfirm -Syy woeusb
sudo pacman -Syy gparted
