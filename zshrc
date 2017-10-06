#### zsh/ohmyzsh

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


#### Environment

## opt to path
path=( $path "$HOME/.local/bin" )

### gpg-agent SSH support
# Fedora: https://github.com/fedora-infra/ssh-gpg-smartcard-config/blob/master/YubiKey.rst
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

### hub (https://github.com/github/hub)
if which hub 2>&1 >/dev/null; then
    alias git=hub
fi

### Langs

## Python
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
virtualenvwrapper_path="$(which virtualenvwrapper.sh)"
if [[ -n "$virtualenvwrapper_path" ]]; then
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    export WORKON_HOME=~/.virtualenvs
    source "$virtualenvwrapper_path"
fi

## Go
GOPATH="$HOME/.local/go"
if [ -d "$GOPATH" ]; then
    export GOPATH
    export path=( $path "$GOPATH/bin" )
fi

## Rust
if [ -d "$HOME/.cargo/" ]; then
    export path=( $path "$HOME/.cargo/bin" )
fi

## Ruby
source "/usr/share/chruby/chruby.sh"
source "/usr/share/chruby/auto.sh"
chruby 2.4 # default to 2.4

## Node
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

## Perl6
if [ -d "$HOME/.perl6/" ]; then
    export path=( $path "$HOME/.perl6/bin" )
fi

## tfenv
if [ -d "$HOME/.tfenv/" ]; then
    export path=( $path "$HOME/.tfenv/bin" )
fi

## Editor
if which nvim >/dev/null; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

## Fix VTE issue: https://gnunn1.github.io/tilix-web/manual/vteconfig/
source /etc/profile.d/vte.sh

## fzf (https://github.com/junegunn/fzf)
export FZF_DEFAULT_COMMAND='rg --files --hidden -F'
export FZF_DEFAULT_OPTS="--height 25% --border"
# FZF ALL THE THINGS (instead of typing **<TAB> as a completion trigger, just <TAB> will do)
export FZF_COMPLETION_TRIGGER="@"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Print packages to update
# Requires passwordless sudo:
# <username> ALL=(ALL) NOPASSWD: /usr/bin/pacman
sudo pacman -Syup --print-format "%n"
