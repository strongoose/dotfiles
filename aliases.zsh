# Things that are technically not aliases
sprunge () {
    cat - | curl -F 'sprunge=<-' http://sprunge.us
}

dn () {
    python -c "import random; print(random.randrange(1, $1 + 1))"
}

SECONDARY_PASS_DIR="$HOME/.mypass"
if [[ -d "$SECONDARY_PASS_DIR" ]]; then
    mypass () {
        PASSWORD_STORE_DIR=~/.mypass pass "$@"
    }

    alias mypcp='mypass show -c'
fi

# Die aliases
for n in $(seq 2 20); do
  alias d$n="dn $n"
done

## Aliases

# Convenience
alias c='cd'
alias gs='g s'
alias l='ls -lhtr'
alias la='ls -lhatr'
alias ll='ls -lhtr'
alias myip='curl icanhazip.com'
alias sl='ls'
alias t='true'

# Common opts
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias pcp='pass show -c'
alias xclip='xclip -selection clipboard'

# Alternative names
alias loc='tokei'
alias nc='ncat'
alias vim='nvim'

# Docker
alias centos='docker run -it --rm centos /bin/bash'
alias ubuntu='docker run -it --rm ubuntu /bin/bash'

# OSX
if [[ "$(uname)" == "Darwin" ]]; then
    alias find='gfind'
    alias sed='gsed'
    alias tar='gtar'
    alias ls='gls --color=auto'
fi
