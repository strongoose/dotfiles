# gpg-agent
if [ -f $HOME/.gpg-agent-info ] && \
    kill -0 $(cut -d: -f 2 $HOME/.gpg-agent-info) 2>/dev/null
then
    export $(cat $HOME/.gpg-agent-info)
    else
        eval `gpg-agent --daemon --write-env-file`
fi 

export GPG_TTY=$(tty)

export HOMEBREW_GITHUB_API_TOKEN=4e0638b515119c317168edd50840cf48f9aece05
