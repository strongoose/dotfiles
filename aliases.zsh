# Things that are technically not aliases
sprunge () {
        cat - | curl -F 'sprunge=<-' http://sprunge.us
}

yamlval () {
    if (ruby -e "require 'yaml'; YAML.load_file('$1')"); then
        echo "That YAML was probably fine."
        return 0
    else
        echo "That was bad YAML."
        return 1
    fi
}

eyamled () {
    for file in $@; do
        recipients=$(find $(dirname $1)/ -maxdepth 1 -mindepth 1 -name '*.rcp')
        if [ $(echo $recipients | wc -l) -gt 1 ]; then
            echo "More than one .rcp file in same directory as $file:\n$recipients" 1>&2; return 1
        elif [ -z $recipients ]; then
            echo "No .rcp file for $file" 1>&2; return 1
        fi
        eyaml edit -n gpg --gpg-always-trust --gpg-recipients-file $recipients $file
    done
}



dn () {
   python -c "import random; print random.randrange(1, $1 + 1)"
}

# Die aliases
for n in 2 3 4 6 8 10 12 20; do
  alias d$n="dn $n"
done

# Aliases
alias grep='grep --color=auto'
alias gs='g s'
alias ls='ls --color=auto'
alias myip='curl icanhazip.com'
alias pcp='pass show -c'
alias sl='ls'
alias upgrade='sudo apt-get update && sudo apt-get upgrade'
alias vim='nvim'
alias xclip='xclip -selection clipboard'
