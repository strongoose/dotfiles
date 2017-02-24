#### zsh/ohmyzsh

# path should be a unique array
typeset -aU path

export ZSH=/home/dan/.oh-my-zsh

ZSH_THEME="ouroboros"

# Timestamp format for history
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

# Set z options before sourcing oh-my-zsh
export _Z_CMD=j

source $ZSH/oh-my-zsh.sh


#### Zsh settings

## Zsh completion help
bindkey '^Xh' _complete_help

## Incremental search
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^F' history-incremental-pattern-search-forward


#### Environment

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
