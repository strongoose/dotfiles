#############################
### Ouroboros's zsh theme ###
#############################

## Error codes
# Error codes listed as keys in the OUROBOROS_THEME_RETURN_REPLACEMENTS
# associative array will be replaced with their value in RPROMPT. It defaults
# to displaying a green ✧ for success, a yellow ✕ for 130 (the usual result of
# ^C) and a red status code otherwise.
#
# You can define a default behaviour with the default key.
#
# Can't tell the difference between an empty and an unset array, so if you want
# to disable it set OUROBOROS_THEME_NO_REPLACEMENT.

typeset -A OUROBOROS_THEME_RETURN_REPLACEMENTS
if [[ -z $OUROBOROS_THEME_NO_REPLACEMENT ]] && [[ -z $OUROBOROS_THEME_RETURN_REPLACEMENTS ]]; then
    OUROBOROS_THEME_RETURN_REPLACEMENTS=(
        0   "%{$fg[green]%}%B·%b%{$reset_color%}"
        130 "%{$fg[yellow]%}X%{$reset_color%}"
    )
fi

function replaced_return() {
    RETURN=${OUROBOROS_THEME_RETURN_REPLACEMENTS[default]:-%{$fg[red]%}%B%?%b%{$reset_color%}}
    unset "OUROBOROS_THEME_RETURN_REPLACEMENTS[default]"
    for code in "${(@k)OUROBOROS_THEME_RETURN_REPLACEMENTS}"; do
        replacement="$OUROBOROS_THEME_RETURN_REPLACEMENTS[$code]"
        RETURN="%($code?:$replacement:$RETURN)"
    done
    echo $RETURN
}

## Virtualenv

function virtualenv_prompt_info(){
  [[ -n ${VIRTUAL_ENV} ]] || return
  echo "%{$fg[yellow]%} ${VIRTUAL_ENV:t} %{$reset_color%}"
}

# disables prompt wrangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

local PROMPT_SYMBOL="%B${PROMPT_SYMBOL:-·}%b"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}$PROMPT_SYMBOL%{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}$PROMPT_SYMBOL%{$fg[magenta]%}"

PROMPT='$(virtualenv_prompt_info)%{$fg[blue]%}%B${PWD/#$HOME/~}%b%{$reset_color%} ${$(git_prompt_info):-${PROMPT_SYMBOL}} %{$reset_color%}'
RPROMPT='$(replaced_return)'
