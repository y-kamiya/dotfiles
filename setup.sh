#!/bin/bash -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)

ln -i -s $SCRIPT_DIR/vim $HOME/.vim
ln -i -s $SCRIPT_DIR/.ctags $HOME/.ctags
ln -i -s $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -i -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -i -s $SCRIPT_DIR/.vrapperrc $HOME/.vrapperrc
ln -i -s $SCRIPT_DIR/.xvimrc $HOME/.xvimrc
ln -i -s $SCRIPT_DIR/.zshrc $HOME/.zshrc
ln -i -s $SCRIPT_DIR/.zprofile $HOME/.zprofile
ln -i -s $SCRIPT_DIR/.ideavimrc $HOME/.ideavimrc

mkdir -p $HOME/.config
ln -i -s $SCRIPT_DIR/vim $HOME/.config/nvim
touch $HOME/.vimrc.local

pushd $SCRIPT_DIR/vim
if [ ! -e venv-python3 ]; then
    python -m venv venv-python3
    source venv-python3/bin/activate
    pip install neovim pynvim
fi
popd
