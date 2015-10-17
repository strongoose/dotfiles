#!/usr/bin/env sh

if [ ! -e ~/.vim/bundle/neobundle.vim ]; then
    echo "Installing NeoBundle"
    curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh
    echo "Done!"
else
    echo "NeoBundle already installed."
fi
