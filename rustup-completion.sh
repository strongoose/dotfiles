#!/bin/bash

set -euo pipefail

if whence rustup >/dev/null 2>&1; then
  mkdir -p ~/.zfunc
  rustup completions zsh > ~/.zfunc/_rustup
else
  echo "$0: rustup not installed, skipping"
fi

