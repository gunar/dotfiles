#!/bin/sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
ln -fs "$(readlink -f zshrc)" ~/.zshrc
ln -fs "$(readlink -f dircolors)" ~/.dircolors

gem install cloudapp_api
