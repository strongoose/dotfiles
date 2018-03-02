#### zsh/ohmyzsh

# Profile zsh start speed
#zmodload zsh/zprof

# path should be a unique array
typeset -aU path

source ~/.dotfiles/antigen/antigen.zsh

antigen bundle git
antigen bundle pip
antigen bundle lein
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle Tarrasch/zsh-autoenv

antigen use oh-my-zsh
antigen theme agnoster

antigen apply


#### z (https://github.com/rupa/z)
export _Z_CMD=j
source ~/.dotfiles/z/z.sh

##### Zsh settings

### Zsh completion help
bindkey '^Xh' _complete_help

### Incremental search
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^F' history-incremental-pattern-search-forward

### Biggest history
export HISTSIZE=9999999999999999 # LONG_MAX (64-bit)
export SAVEHIST=9999999999999999

### Aliases
source ~/.dotfiles/aliases.zsh

### hub (https://github.com/github/hub) and lab (https://github.com/zaquestion/lab)
# Prefer lab because it's hub-aware
if which lab 2>&1 >/dev/null; then
    alias git=lab
elif which hub 2>&1 >/dev/null; then
    alias git=hub
fi

### Langs

## RVM
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## Fix VTE issue (for Tilix): https://gnunn1.github.io/tilix-web/manual/vteconfig/
VTE_PROFILE=/etc/profile.d/vte.sh
if [[ -e "$VTE_PROFILE" ]]; then
    source /etc/profile.d/vte.sh
fi

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Print packages to update
# Requires passwordless sudo:
# <username> ALL=(ALL) NOPASSWD: /usr/bin/pacman
if grep 'Arch Linux' /etc/os-release >/dev/null 2>&1; then
    sudo pacman -Syup --print-format "%n"
fi
