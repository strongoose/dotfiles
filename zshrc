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

## opt to path
path=( $path /opt/bin "$HOME/.local/bin" )

### gpg-agent SSH support
# Fedora: https://github.com/fedora-infra/ssh-gpg-smartcard-config/blob/master/YubiKey.rst
if [ -f /etc/fedora-release ]; then
    if [ ! -f /run/user/$(id -u)/gpg-agent.env ]; then
        killall gpg-agent;
        eval $(gpg-agent --daemon --enable-ssh-support > /run/user/$(id -u)/gpg-agent.env);
    fi
    . /run/user/$(id -u)/gpg-agent.env
fi

### Langs

## RVM
export path=( $path "$HOME/.rvm/bin" ) # Add RVM to path for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## Python
export VIRTUALENVWRAPPER_PYTHON="/usr/bin/python3"
virtualenvwrapper_path="$(which virtualenvwrapper.sh)"
if [[ -n "$virtualenvwrapper_path" ]]; then
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    export WORKON_HOME=~/.virtualenvs
    source "$virtualenvwrapper_path"
fi

## Go
GOPATH='/usr/local/go/'
if [ -d "$GOPATH" ]; then
    export GOPATH
    export path=( $path "$GOPATH/bin" )
fi

## Rust
if [ -d "$HOME/.cargo/" ]; then
    export path=( $path "$HOME/.cargo/bin" )
fi

# Editor
if which nvim >/dev/null; then
    export EDITOR='nvim'
else
    export EDITOR='vim'
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
