_dbgcmp() {
    echo $(gdate --iso=s) $@ >> ~/tmp/zshcompletiondebug.log
}

_fzf_complete_git() {
    # The `z` parameter expansion flag splits the variable using shell parsing
    # See https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags:~:text=z,-Split
    local cmd=( "${(z)@}" )
    local branches=$(git branch -vv | grep -v '^*')
    local complete_for=( 'checkout' 'switch' 'c' 'w' )
    # [(I)bla] returns the index of bla in the array, or 0 if no match
    if [[ -n "${complete_for[(I)$cmd]}" ]]; then
        _fzf_complete --reverse --multi -- "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

_fzf_complete_g() {
    _fzf_complete_git "$@"
}

_fzf_complete_g_post() {
    _fzf_complete_git_post "$@"
}

_fzf_complete_gh() {
    # The `z` parameter expansion flag splits the variable using shell parsing
    # See https://zsh.sourceforge.io/Doc/Release/Expansion.html#Parameter-Expansion-Flags:~:text=z,-Split
    local cmd=( "${(z)@}" )
    local branches=$(git branch -vv | grep -v '^*')
    local complete_for=( 'stack' )
    # [(I)bla] returns the index of bla in the array, or 0 if no match
    if [[ -n "${complete_for[(I)$cmd]}" ]]; then
        _fzf_complete --reverse --multi -- "$@" < <(
            echo $branches
        )
    else
        eval "zle ${fzf_default_completion:-expand-or-complete}"
    fi
}

_fzf_complete_gh_post() {
    awk '{print $1}'
}

