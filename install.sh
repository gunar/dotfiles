# git
ln -s "$(readlink -f git/gitconfig)" ~/.gitconfig

# awesome wm
ln -s "$(readlink -f awesome)" ~/.config/

# Tmux
ln -s "$(readlink -f tmux/tmux.conf)" ~/.tmux.conf
ln -s "$(readlink -f tmux)" ~/.tmux

# Zsh
ln -s "$(readlink -f zsh/zshrc)" ~/.zshrc

# NeoVim
mkdir -p ~/.config/nvim
ln -s "$(readlink -f nvim/nvim.vim)" ~/.config/nvim/init.vim
ln -s "$(readlink -f nvim/settings)" ~/.config/nvim/settings

# Termite
mkdir -p ~/.config/termite
ln -s "$(readlink -f termite/termite.conf)" ~/.config/termite/config
