#! /bin/bash

set -euo pipefail

kitty_dir="$HOME/.config/kitty"

mkdir -p "$kitty_dir"
cd "$kitty_dir"

# fetch themes
curl -s -O https://raw.githubusercontent.com/ouroboros8/kitty-gruvbox-theme/master/gruvbox_dark.conf
curl -s -O https://raw.githubusercontent.com/ouroboros8/kitty-gruvbox-theme/master/gruvbox_light.conf

# setup nvim-kitty-navigator
pip install pynvim
curl -s -O https://raw.githubusercontent.com/ouroboros8/nvim-kitty-navigator/main/navigate.py
