#### zsh/ohmyzsh

# Profile zsh start speed
#zmodload zsh/zprof

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

### Environment

## gopass completion
export fpath=( "$HOME/.local/go/share/zsh/site-functions" $fpath )

## tfenv
if [ -d "$HOME/.tfenv/" ]; then
    path=( "$HOME/.tfenv/bin" $path )
fi

## Editor
if which nvim >/dev/null; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

## gpg-agent (with SSH support)
# Some nonsense required in Fedora:
# https://github.com/fedora-infra/ssh-gpg-smartcard-config/blob/master/YubiKey.rst
if [ -f /etc/fedora-release ]; then
    if [ ! -f /run/user/$(id -u)/gpg-agent.env ]; then
        killall gpg-agent;
        eval $(gpg-agent --daemon --enable-ssh-support > /run/user/$(id -u)/gpg-agent.env);
    fi
    . /run/user/$(id -u)/gpg-agent.env
else
    gpg-connect-agent /bye 2>&1 >/dev/null
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
fi

## fzf (https://github.com/junegunn/fzf)
export FZF_DEFAULT_COMMAND='rg --files --hidden -F'
export FZF_CTRL_T_COMMAND='rg --files --hidden -F'
export FZF_DEFAULT_OPTS="--height 25% --border"

### Development

## Python (virtualenvwrapper)
virtualenvwrapper_path="$(which virtualenvwrapper.sh)"
if [[ -n "$virtualenvwrapper_path" ]]; then
    export VIRTUALENVWRAPPER_PYTHON=$(which python3 || which python)
    export WORKON_HOME=~/.virtualenvs
    source "$virtualenvwrapper_path"
fi

## Go
if go version 2>&1 >/dev/null; then
    GOPATH="$HOME/.local/go"
    mkdir -p $GOPATH
    export GOPATH
    path=( "$GOPATH/bin" $path )
fi

## Rust
if [ -d "$HOME/.cargo/" ]; then
    path=( "$HOME/.cargo/bin" $path )
fi

## Perl6
if [ -d "$HOME/.perl6/" ]; then
    path=( "$HOME/.perl6/bin" $path )
fi

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

# Scripts in $HOME/.local/bin take precedence:
path=( "$HOME/.local/bin" $path )

# dedupe path array (-U is for unique array)
typeset -aU path
export path

# Co-op SSH helper
helper_path="$HOME/coop/dotfiles/coop_ssh"
if [[ -f "$helper_path" ]]; then
    source "$helper_path"
fi

# Print packages to update
# Requires passwordless sudo:
# <username> ALL=(ALL) NOPASSWD: /usr/bin/pacman
if grep 'Arch Linux' /etc/os-release >/dev/null 2>&1; then
    sudo pacman -Syup --print-format "%n"
fi
