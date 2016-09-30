#### zsh/ohmyzsh

# path should be a unique array
typeset -aU path

## Zsh completion help
bindkey '^Xh' _complete_help


export ZSH=/home/dan/.oh-my-zsh

ZSH_THEME="ouroboros"

# Timestamp format for history
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

# Set z options before sourcing oh-my-zsh
export _Z_CMD=j

source $ZSH/oh-my-zsh.sh


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

## Ruby (rvm)
export path=( $path $HOME/.rvm/bin ) # Add RVM to path for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## pyenv
export path=( /home/dan/.pyenv/bin $path )
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper

## Go
if [ -d ~/go ]; then
    export GOPATH=~/go
    export path=( $path ~/go/bin )
fi

## Rust
if [ -d $HOME/.cargo/ ]; then
    export path=( $path $HOME/.cargo/bin )
fi
