#!/bin/sh
./pulseaudio/install.sh

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
sudo pacman -Syy fasd yay zip extra/unzip community/tldr extra/keychain extra/lxsession upower community/the_silver_searcher extra/imagemagick community/fzf extra/alsa-utils extra/pavucontrol extra/xorg-xinput community/npm community/xautolock openssh net-tools extra/python-pip extra/python2-pip extra/graphviz extra/gnu-netcat extra/vlc ruby qt4 xdot aria2 aria2 xf86-video-fbdev

yay -Syy aur/vlock-original  community/xlockmore aur/nvm
sudo pacman -Syy extra/xorg-clipboard
sudo pacman -Syy extra/xorg-xclipboard
sudo pacman -Syy xf86-video-intel
sudo pacman -Syy xf86-input-synaptics

yay -Syy aur/chromium-widevine
sudo pacman -Syy extra/pepper-flash
sudo pacman -Syy extra/xorg-xkill
sudo pacman -Syy extra/xfce4-screenshooter
sudo pacman -Syy xorg-xev
sudo pacman -Syy gpick
sudo pacman -Syy xorg-xdpyinfo
sudo pacman -Syy thunar
sudo pacman -Syy xss-lock
sudo pacman -Syy community/picom
sudo pacman -Syy viewnior
sudo pacman -Syy xfce4-taskmanager
sudo pacman -Syy tree
sudo pacman -Syy hub
yay --noconfirm -Syy shutter
sudo pacman -Syy youtube-dl
sudo pacman -Syy galculator
sudo pacman -Syy pandoc
sudo pacman -Syy libmcrypt
sudo pacman -Syy xfce4-settings
sudo pacman -Syy autofs
sudo pacman -Syy calibre
sudo pacman -Syy lsof
sudo pacman -Syy libva-intel-driver libvdpau-va-gl mesa lib32-mesa vulkan-intel lib32-vulkan-intel
sudo pacman -Syy libva-utils
sudo pacman -Syy vdpauinfo
sudo pacman -Syy xorg-xmodmap
yay --noconfirm -Syy pstate-frequency
yay --noconfirm -Syy fancontrol-gui
sudo pacman -Syy stress
sudo pacman -Syy namcap
sudo pacman -Syy moreutils
sudo pacman -Syy bluez bluez-utils
sudo pacman -Syy pulseaudio-bluetooth
sudo pacman -Syy bluez-libs
yay --noconfirm -Syy xmacro
sudo pacman -Syy extra/xorg-fonts-100dpi extra/xorg-fonts-75dpi
sudo pacman -Syy extra/xorg-fonts-misc
yay --noconfirm -Syy community/wmctrl
yay --noconfirm -Syy boot
yay --noconfirm -Syy bdf-creep
sudo pacman -Syy unrar
sudo pacman -Syy guvcview
sudo pacman -Syy scrot
sudo pacman -Syy i3lock
yay --noconfirm -Syy teamviewer
yay --noconfirm -Syy teamviewer
yay --noconfirm -Syy teamviewer12
sudo pacman -Syy iftop
yay --noconfirm -Syy geoclue2
sudo pacman -Syy catdoc
sudo pacman -Syy qemu-arch-extra
sudo pacman -Syy qemu
yay --noconfirm -Syy clover-efi
yay --noconfirm -Syy uml_utilities
sudo pacman -Syy arp-scan
sudo pacman -Syy libmicrodns
sudo pacman -Syy protobuf
yay --noconfirm -Syy castnow-git
sudo pacman -Syy minidlna
sudo pacman -Syy tumbler
yay --noconfirm -Syy autokey-py3
sudo pacman -Syy filezilla
sudo pacman -Syy inkscape
yay --noconfirm -Syy flameshot
sudo pacman -Syy docker docker-compose
yay --noconfirm -Syy ttf-twemoji-color
sudo pacman -Syy mlocate
yay --noconfirm -Syy up
sudo pacman -Syy colordiff
yay --noconfirm -Syy warsaw-bin
yay --noconfirm -Syy ttf-emojione-color
yay --noconfirm -Syy ttf-emojione
yay --noconfirm -Syy ibus-uniemoji
sudo pacman -Syy ibus
sudo pacman -Syy ibus-qt
sudo pacman -Syy anki
sudo pacman -Syy pgadmin4
sudo pacman -Syy tor
yay --noconfirm -Syy tor-browser
sudo pacman -Syy shellcheck
yay --noconfirm -Syy ladspa-bs2b
yay --noconfirm -Syy parcel-bundler
sudo pacman -Syy fish
yay --noconfirm -Syy debtap
yay --noconfirm -Syy bat
sudo pacman -Syy siege
sudo pacman -Syy shellcheck
sudo pacman -Syy mps-youtube
sudo pacman -Syy exa
sudo pacman -Syy jq
yay --noconfirm -Syy jiq
sudo pacman -Syy httpie
yay --noconfirm -Syy lsix
yay --noconfirm -Syy mysql-clients
yay --noconfirm -Syy lighttable-bin
yay --noconfirm -Syy pgcli
sudo pacman -Syy beep
sudo pacman -Syy mpg123
yay --noconfirm -Syy clojure
yay --noconfirm -Syy parsec-bin
sudo pacman -Syy vinagre
yay --noconfirm -Syy woeusb
sudo pacman -Syy gparted
yay --noconfirm -Syy onionshare
sudo pacman -Syy parallel
sudo pacman -Syy community/python2-psycopg2
sudo pacman -Syy keepassxc
yay --noconfirm -Syy insync
yay --noconfirm -Syy grive
sudo pacman -Syy inotify-tools
sudo pacman -Syy unison
sudo pacman -Syy dnsutils
sudo pacman -Syy nmap
sudo pacman -Syy wine
sudo pacman -Syy anki
sudo pacman -Syy linux414-tp_smapi
sudo pacman -Syy linux419-tp_smapi
yay --noconfirm -Syy tp_smapi-dkms
sudo pacman -Syy acpi_call-dkms
sudo pacman -Syy tpacpi-bat
sudo pacman -Syy linux419-acpi_call
yay --noconfirm -Syy direnv
yay --noconfirm -Syy planck-git
sudo pacman -Syy lutris
sudo pacman -Syy dbeaver
yay --noconfirm -Syy yay
yay --Syy nodejs-tldr
yay --Syy google-cloud-sdk
sudo pacman -Syy sshfs
sudo pacman -Syy krename
sudo pacman -Syy aiksaurus
sudo pacman -Syy musescore
sudo pacman -Syy fd
sudo pacman -Syy extra/linux419-tp_smapi
sudo pacman -Syy downgrade
sudo pacman -Syy peek
yay --Syy zsh-theme-powerlevel9k
sudo pacman -Syy firefox
sudo pacman -Syy emacs
yay --Syy adobe-base-14-fonts
sudo pacman -Syy pdftk

sudo ./fontconfig/install.sh
sudo ./org-protocol/install.sh
yay --Syy magic-wormhole-git
sudo pacman -Syy nethogs
sudo pacman -Syy stunnel
yay --Syy zoom
yay --Syy babashka-bin
sudo pacman -Syy swaks
sudo pacman -Syy nnn
sudo pacman -Syy torsocks
yay --Syy ffmpeg-normalize
sudo pacman -Syy terraform
yay --Syy semgrep-bin
sudo pacman -Syy aws-cli
yay --Syy pulumi
yay --Syy pulumi
sudo pacman -Syy asciinema
yay --Syy pulumi
sudo pacman -Syy xsensors
yay --Syy lm_sensors
sudo pacman -Syy socat
sudo pacman -Syy tidy
yay --Syy cloudflared
yay --Syy mongodb-tools-bin
sudo pacman -Syy pv
