#!/bin/bash

set -euo pipefail

warn() {
  1>&2 echo "$@"
}

##
# If rustup is installed, generate zsh completions
##
rustup_completion() {
  if which rustup >/dev/null 2>&1; then
    mkdir -p ~/.zfunc
    rustup completions zsh > ~/.zfunc/_rustup
  else
    warn "rustup not installed, skipping"
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
  curl -sSf -O https://raw.githubusercontent.com/ouroboros8/kitty-gruvbox-theme/master/gruvbox_dark.conf
  curl -sSf -O https://raw.githubusercontent.com/ouroboros8/kitty-gruvbox-theme/master/gruvbox_light.conf
}
kitty

##
# Install vim-plug
##
vimplug() {
  plugpath="${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim

  if ! [[ -f "$plugpath" ]]; then
    curl -sSfLo "$plugpath" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  fi
}
vimplug


##
# Install Rye and Neovim virtualenvs
##
neovenv() {
  major=$1

  venvpath="$HOME/.neovenv"

  if ! [[ "$(which python)" == *".rye/shims/python"* ]]; then
    warn "Error: installing Neovim virtual environment - rye required"
    warn "  curl -sSf https://rye.astral.sh/get | bash"
    return
  fi

  # Create virtualenvs, if missing
  if [[ -d "$venvpath" ]] ; then
    warn "Already got $venvpath virtual environment, skipping"
    return
  fi

  venv="neovim$major"
  python -m venv "$venvpath"
  (
    source "${venvpath}/bin/activate"
    pip install neovim
  )

  cat<<EOF
NeoVim virtualenv for $venv installed. Add the following line to your nvim.init:

let g:python${major/2/}_host_prog = '${venvpath}/bin/python'

EOF
}
neovenv 3

##
# Set up bat with catppuccin themes
##
bat_themes() {
  if ! which bat >/dev/null 2>&1; then
    warn "bat not installed, skipping theme setup"
    return
  fi

  if bat --list-themes | grep Catppuccin >/dev/null 2>&1; then
    warn "catppuccin theme for bat already installed"
    return
  fi

  local config_dir="$(bat --config-dir)/themes"
  mkdir -p "$config_dir"
  wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
  wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
  wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
  wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

  bat cache --build
}
bat_themes
