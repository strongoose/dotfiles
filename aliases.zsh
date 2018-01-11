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

# Aliases
alias c='cd'
alias centos='docker run -it --rm centos /bin/bash'
alias grep='grep --color=auto'
alias gs='g s'
alias ls='ls --color=auto'
alias myip='curl icanhazip.com'
alias nc='ncat'
alias pcp='pass show -c'
alias sl='ls'
alias t='true'
alias ubuntu='docker run -it --rm ubuntu /bin/bash'
alias vim='nvim'
alias xclip='xclip -selection clipboard'
alias loc='tokei'
alias l='ls -lhtr'
alias ll='ls -lhtr'
alias la='ls -lhatr'

# OSX
if [[ "$(uname)" == "Darwin" ]]; then
    alias find='gfind'
    alias sed='gsed'
    alias tar='gtar'
    alias ls='gls --color=auto'
fi
