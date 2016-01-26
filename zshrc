# Path to your oh-my-zsh installation.
export ZSH=/home/gcg/.oh-my-zsh

ZSH_THEME="agnoster"
HIST_STAMPS="yyyy-mm-dd"
plugins=(git jsontools sudo)

export PATH="/home/gcg/.gem/ruby/2.3.0/bin:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
#
alias vincenza='ssh -o PubKeyAuthentication=no -p 2222 vincenza@maisonvincenza.com.br'
export VISUAL=nvim
export EDITOR="$VISUAL"
alias n='nvim'

eval $(dircolors ~/.dircolors)

eval $(keychain --eval --quiet id_rsa)

if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi
