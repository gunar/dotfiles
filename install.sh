ln -s "$(readlink -f tmux.conf)" ~/.tmux.conf

mkdir -p ~/.config/nvim
ln -s "$(readlink -f nvim.vim)" ~/.config/nvim/init.vim

mkdir -p ~/.config/termite
ln -s "$(readlink -f termite.conf)" ~/.config/termite/config
