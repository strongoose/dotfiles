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

  declare config_dir
  config_dir="$(bat --config-dir)/themes"
  mkdir -p "$config_dir"
  wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
  wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Frappe.tmTheme
  wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
  wget -P "$config_dir/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme

  bat cache --build
}
bat_themes
