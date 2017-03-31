#### zsh/ohmyzsh

# path should be a unique array
typeset -aU path

source ~/.dotfiles/antigen/antigen.zsh

antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen use oh-my-zsh
antigen theme agnoster

antigen apply


#### Z (could probably manage this with antigen)
export _Z_CMD=j
source ~/.dotfiles/z.zsh

##### Zsh settings

### Zsh completion help
bindkey '^Xh' _complete_help

### Incremental search
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^F' history-incremental-pattern-search-forward

## Timestamp format for history
export SHARE_HISTORY="true"

### Biggest history
export HISTSIZE=9223372036854775807 # LONG_MAX (64-bit)
export SAVEHIST=9223372036854775807

### Aliases
source ~/.dotfiles/aliases.zsh


#### Environment

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi
