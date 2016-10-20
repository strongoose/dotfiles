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

## opt to path
path=( $path /opt/bin )


#### Langs

## RVM
export path=( $path $HOME/.rvm/bin ) # Add RVM to path for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## pyenv
if [[ -s "$HOME/.pyenv/bin" ]]; then
    export path=( /home/dan/.pyenv/bin $path )
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    # This step is really slow (0.8s on first loading a new shell, 0.5 thereafter)
    # The lazy version is faster, but still 0.3s on first load (reload with lazy is
    # snappy)
    pyenv virtualenvwrapper
fi

## Go
if [ -d ~/go ]; then
    export GOPATH=~/go
    export path=( $path ~/go/bin )
fi

## Rust
if [ -d $HOME/.cargo/ ]; then
    export path=( $path $HOME/.cargo/bin )
fi
