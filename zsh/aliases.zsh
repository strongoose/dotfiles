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

proceed() {
    if [[ -n "$1" ]]; then
        prompt=$1
    else
        prompt="Proceed?"
    fi
    local confirm
    while [[ -z "$confirm" ]]; do
        1>&2 read -r "confirm?$prompt (yes/no) "
        if [[ "$confirm" != "yes" ]] && [[ "$confirm" != "no" ]]; then
            1>&2 echo "Please answer exactly yes or no (case-sensitive)"
            unset confirm
        fi
    done
    if [[ "$confirm" == "yes" ]]; then
        echo "yes"
    else
        echo "no"
    fi
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

# Die aliases
for n in 4 6 8 10 12 20; do
  alias d$n="dn $n"
done

## Aliases

# Convenience
alias c='cd'
alias g='git'
alias k='kubectl'
alias l='ls -lh'
alias la='ls -lha'
alias ll='ls -lh'
alias myip='curl -s icanhazip.com'
alias t='true'
alias ipgrep="rg '([0-9]{1,3}\.){3}[0-9]{1,3}(/[0-9]{1,2})?'"

# Dangerous
# These aliases are prefixed with a bare read; they require double tapping enter to execute.
alias 'frig!'='read && git commit -a --amend --no-edit && git push -f'

# Common opts
alias grep='grep --color=auto'
alias ls='ls --color=auto'
alias pcp='gopass show -c'
alias xclip='xclip -selection clipboard'
alias qmv='qmv -o tabsize=4' # To match my nvim tabsize

# Alternative names
alias loc='tokei'
alias nc='ncat'
alias pass='gopass'
alias vim='nvim'

# Typos
alias sl='ls'
alias ivm='vim'
alias gs='g s'

# Docker
alias ubuntu='docker run -it --rm ubuntu /bin/bash'
alias centos='docker run -it --rm centos /bin/bash'
alias atestalias='echo test'

# OSX
if [[ "$OSTYPE" =~ darwin ]]; then
    alias find='gfind'
    alias sed='gsed'
    alias tar='gtar'
    alias ls='exa --color=auto'
fi
