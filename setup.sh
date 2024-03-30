#!/bin/bash

set -euo pipefail

##
# If rustup is installed, generate zsh completions
##
rustup_completion() {
  if whence rustup >/dev/null 2>&1; then
    mkdir -p ~/.zfunc
    rustup completions zsh > ~/.zfunc/_rustup
  else
    echo "$0: rustup not installed, skipping"
  fi
}
rustup_completion

##
# Set up kitty with gruvbox themes
##
kitty() {
  kitty_dir="$HOME/.config/kitty"

  mkdir -p "$kitty_dir"
  cd "$kitty_dir"

  # fetch themes
  curl -s -O https://raw.githubusercontent.com/ouroboros8/kitty-gruvbox-theme/master/gruvbox_dark.conf
  curl -s -O https://raw.githubusercontent.com/ouroboros8/kitty-gruvbox-theme/master/gruvbox_light.conf
}
kitty

##
# Install neovim python host packages
##
neovenv() {
  major=$1

  # Install python, if missing
  python=$(pyenv versions --bare | grep -E "^3(\.[0-9]+){2}$" || echo)

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
NeoVim virtualenv for $venv installed. Add the following line to your nvim.init:

  let g:python${major/2/}_host_prog = '$(pyenv which python)'

EOF
}
neovenv 3
