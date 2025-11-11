# Things that are technically not aliases
dn () {
    python -c "import random; print(random.randrange(1, $1 + 1))"
}

yaml2json () {
    ruby -e "require 'yaml'; require 'json'; puts YAML.load(STDIN.read).to_json"
}

json2yaml () {
    ruby -e "require 'yaml'; require 'json'; puts JSON.load(STDIN.read).to_yaml"
}

countdown() {
    start="$(( $(gdate '+%s') + $1))"
    while [ $start -ge $(gdate +%s) ]; do
        time="$(( $start - $(gdate +%s) ))"
        printf '%s\r' "$(gdate -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

stopwatch() {
    start=$(gdate +%s)
    while true; do
        time="$(( $(gdate +%s) - $start))"
        printf '%s\r' "$(gdate -u -d "@$time" +%H:%M:%S)"
        sleep 0.1
    done
}

fib () {
    i=${1:-10}
    prev=0
    n=1
    while [[ "$i" != 0 ]]; do
        echo -n "$n "

        n=$((n + prev))
        prev=$((n - prev))

        i=$((i - 1))
    done
    echo
}

cached_aws_creds () {
    unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN
    aws s3 ls >/dev/null
    latest_creds=$(command ls -1t ~/.aws/cli/cache/ | head -1)
    export AWS_ACCESS_KEY_ID=$(cat "${HOME}/.aws/cli/cache/${latest_creds}" | jq -r '.Credentials.AccessKeyId')
    export AWS_SECRET_ACCESS_KEY=$(cat "${HOME}/.aws/cli/cache/${latest_creds}" | jq -r '.Credentials.SecretAccessKey')
    export AWS_SESSION_TOKEN=$(cat "${HOME}/.aws/cli/cache/${latest_creds}" | jq -r '.Credentials.SessionToken')
}

git-purge () {
    non_master_branches=$(git branch | grep -v master)
    echo "This will force delete (git branch -D) all non-master branches"
    if [[ -z "$non_master_branches" ]]; then
        echo "No non-master branches to delete"
        return
    fi
    echo "Branches up for deletion:"
    echo "$non_master_branches"
    if [[ "$(proceed 'Are you sure?')" != "yes" ]]; then
        echo "Aborting due to user input"
    else
        echo $non_master_branches | xargs git branch -D
    fi
}

base64url () {
    base64 $@ | tr + - | tr / _ | sed 's/=*$//'
}

colours () {
    for n in $(seq 31 37); do
        echo -n "\e[1;${n}mECHO\e[0m "
    done
    echo
    for n in $(seq 91 97); do
        echo -n "\e[1;${n}mECHO\e[0m "
    done
    echo
}

mc () {
    mkdir -p "$@"
    cd "$@"
}

# Die aliases
for n in 4 6 8 10 12 20; do
  alias d$n="dn $n"
done

## Aliases
alt () {
    # If cmd exists, create an alias to it for each additional argument
    cmd=$1; shift
    whence $cmd >/dev/null || return

    for al in $@; do alias "$al=$cmd"; done
}

# Convenience
alias c='cd'
alias l='ls -lh'
alias la='ls -lha'
alias ll='ls -lh'
alias myipv4='curl -s -4 icanhazip.com'
alias myipv6='curl -s -6 icanhazip.com'
alias myip='myipv4'
alias t='true'
alias ipgrep="rg '([0-9]{1,3}\.){3}[0-9]{1,3}(/[0-9]{1,2})?'"
alias chomp="tr -d '\n'"

# Common opts
alias grep='grep --color=auto'
alias xclip='xclip -selection clipboard'
alias qmv='qmv -o tabsize=4' # To match my nvim tabsize
alias ls='ls --color=auto'

# Alternative names
alt  git        g
alt  terraform  tf
alt  fossil     f
alt  kubectl    k
alt  tokei      loc
alt  ncat       nc
alt  nvim       vim ivm
alt  podman     docker
alt  kubens     kns
alt  kubectx    ktx

# Typos
alias sl='ls'
alias gs='g s'

# Docker
alias ubuntu='docker run -it --rm ubuntu /bin/bash'
alias centos='docker run -it --rm centos /bin/bash'
