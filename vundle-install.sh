#!/usr/bin/env sh

if [ ! -e ~/.config/nvim/bundle/Vundle.vim ]; then
    echo "Cloning Vundle."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.config/nvim/bundle/Vundle.vim
else
    echo "Vundle already installed."
fi
