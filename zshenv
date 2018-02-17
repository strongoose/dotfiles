## Homebrew
if [[ $(uname) == 'Darwin' ]]; then
    path=( /usr/local/bin $path )
fi

## Some misc scripts and things go in .local/bin
path=( $path $HOME/.local/bin )

## gopass completion
export fpath=( $fpath "$HOME/.local/go/share/zsh/site-functions" )

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
export FZF_DEFAULT_OPTS="--height 25% --border"

### Development

## Python (virtualenvwrapper)
virtualenvwrapper_path="$(which virtualenvwrapper.sh)"
if [[ -n "$virtualenvwrapper_path" ]]; then
    export VIRTUALENVWRAPPER_PYTHON=$(which python3)
    export WORKON_HOME=~/.virtualenvs
    source "$virtualenvwrapper_path"
fi

## Go
if go version 2>&1 >/dev/null; then
    GOPATH="$HOME/.local/go"
    mkdir -p $GOPATH
    export GOPATH
    export path=( $path "$GOPATH/bin" )
fi

## Rust
if [ -d "$HOME/.cargo/" ]; then
    export path=( $path "$HOME/.cargo/bin" )
fi

## Perl6
if [ -d "$HOME/.perl6/" ]; then
    export path=( $path "$HOME/.perl6/bin" )
fi

## Ruby
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export path=( $path "$HOME/.rvm/bin" )
