# Virtualenvwrapper
export WORKON_HOME=~/.venvs
mkdir -p $WORKON_HOME

source /usr/bin/virtualenvwrapper.sh

# Virtualenv prompt

function virtual_env_prompt () {
  REPLY=${VIRTUAL_ENV+${VIRTUAL_ENV:t}}
  if [ ! -z $REPLY ]; then
      REPLY="%F{magenta}{%f%F{cyan}$REPLY%F{magenta}}%f "
  fi
}
grml_theme_has_token venv || grml_theme_add_token venv -f virtual_env_prompt

zstyle ':prompt:grml:left:setup' items rc change-root user at host\
                                 path venv vcs percent

# Aliases
source ~/.alias