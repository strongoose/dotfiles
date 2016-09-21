#### zsh/ohmyzsh

## Zsh completion help
bindkey '^Xh' _complete_help


export ZSH=/home/dan/.oh-my-zsh

ZSH_THEME="random"

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

## opt to PATH
PATH=$PATH:/opt/bin


#### Langs

## Ruby (rvm)
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## pyenv
export PATH="/home/dan/.pyenv/bin:$PATH"
export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
pyenv virtualenvwrapper

## Go
if [ -d ~/go ]; then
    export GOPATH=~/go
    export PATH=$PATH:~/go/bin
fi

## NVM
export NVM_DIR="/home/dan/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
