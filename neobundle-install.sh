#!/usr/bin/env sh

if [ ! -e ~/.vim/bundle/neobundle.vim ]; then
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
else
    echo "NeoBundle already installed."
fi
