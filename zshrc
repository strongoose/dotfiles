#### zsh/ohmyzsh

export ZSH=/home/dan/.oh-my-zsh

ZSH_THEME="random"

# Timestamp format for history
HIST_STAMPS="yyyy-mm-dd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

#### Environment

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
