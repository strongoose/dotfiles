#!/bin/bash

set -euo pipefail

setup() {
  major=$1

  # Install python, if missing
  python=$(pyenv versions | grep -E "^ *${major}(\.[0-9]+){2}$" | xargs || echo)

  if [[ -z "$python" ]]; then
    newest=$(pyenv install --list \
      | grep -E "^ *${major}(\.[0-9]+){2}$" \
      | sort -V | tail -n1 | xargs
    )
    pyenv install "$newest"
    python="$newest"
  fi

  # Create virtualenvs, if missing
  venv="neovim$major"
  if [[ -z $(pyenv virtualenvs | grep "$venv") ]]; then
    pyenv virtualenv "$python" "$venv"
  fi

  # Install neovim package, if missing
  set +u
  eval "$(pyenv init -)"
  pyenv activate "$venv"
  set -u
  if ! pip freeze | grep neovim >/dev/null 2>&1; then
    pip install neovim
  fi

  cat<<EOF
NeoVim virtualenv for $venv installed. Add the following line to your zshrc:

  let g:python${major/2/}_host_prog = '$(pyenv which python)'

EOF
}

setup 2
setup 3
