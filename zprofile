## opt to path
path=( $path /opt/bin )


#### Langs

## RVM
export path=( $path $HOME/.rvm/bin ) # Add RVM to path for scripting
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

## Python
export WORKON_HOME=~/.virtualenvs
source /usr/bin/virtualenvwrapper.sh

## Go
GOPATH='/usr/local/go/'
if [ -d $GOPATH ]; then
    export GOPATH
    export path=( $path $GOPATH/bin )
fi

## Rust
if [ -d $HOME/.cargo/ ]; then
    export path=( $path $HOME/.cargo/bin )
fi