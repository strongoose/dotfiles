# For gpg key re-encryption etc
if [ $(ps ax|grep -i gpg-agent| grep $(whoami) | wc -l) -eq 0 ];then
    eval $(gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info" "$@")
fi

if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
fi

export HOMEBREW_GITHUB_API_TOKEN=4e0638b515119c317168edd50840cf48f9aece05
