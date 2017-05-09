# Things that are technically not aliases
sprunge () {
    cat - | curl -F 'sprunge=<-' http://sprunge.us
}

gtf () {
    LATEST_RELEASE=$(curl https://api.github.com/repos/hashicorp/terraform/releases/latest | jq --raw-output '.tag_name' | cut -c 2-)
    if [[ $(terraform --version | head -n1 | sed 's/^Terraform v//') != ${LATEST_RELEASE} ]]; then
       echo "Installing Terraform ${LATEST_RELEASE}..."
       curl https://releases.hashicorp.com/terraform/${LATEST_RELEASE}/terraform_${LATEST_RELEASE}_linux_amd64.zip | gunzip - > /opt/bin/terraform
       sudo chmod 775 /opt/bin/terraform
    else
       echo "Latest Terraform already installed."
    fi
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
    python -c "import random; print(random.randrange(1, $1 + 1))"
}

bp () {

    usage () {
        >&2 echo "$0 [ --python ] DEST"
    }

    FORCE="false"

    [ $# -eq 0 ] && usage

    while [ $# -ge 1 ]; do
        case $1 in
            -f)
                FORCE="true"
                ;;
            --python)
                LANG=python
                ;;
            *)
                if [ $# -ge 2 ]; then
                    usage
                    return
                else
                    DEST=$1
                fi
                ;;
        esac
        shift
    done

    if [[ -e $DEST ]] && ! $FORCE; then
        echo "Destination file $DEST already exists!"
        return
    fi

    if [[ "$LANG" == "python" ]]; then
        cat<<EOS > $DEST
#!/usr/bin/env python
'''
FIXME: docstring
'''
import argparse

def parse_args():
    '''
    Parse script arguments.
    '''

    parser = argparse.ArgumentParser(
        description='FIXME: script description'
    )

    parser.add_argument('ARG', help='')

    return parser.parse_args()

if __name__ == '__main__':

    ARGS = parse_args()
EOS
    else
        cat<<EOS > $DEST
#!/bin/bash

set -eo pipefail

function err {
  >&2 echo "\$@"
  exit 1
}

function usage {
  usage=\$(cat<<EOF
Usage: $0 ARGS

FIXME: description.
EOF
)
  err "\$usage"
}

[ \$# -eq 0 ] && usage

while [ \$# -ge 1 ]; do
    case \$1 in
        --opts)
            OPTS="FIXME"
            ;;
        *)
            usage
            ;;
    esac
    shift
done
EOS
    fi

}

# Die aliases
for n in 2 3 4 6 8 10 12 20; do
  alias d$n="dn $n"
done

# Aliases
alias c='cd'
alias grep='grep --color=auto'
alias gs='g s'
alias ls='ls --color=auto'
alias myip='curl icanhazip.com'
alias pcp='pass show -c'
alias sl='ls'
alias upgrade='sudo apt-get update && sudo apt-get upgrade'
alias vim='nvim'
alias xclip='xclip -selection clipboard'
