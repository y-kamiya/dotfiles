#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

ln -i -s $SCRIPT_DIR/vim $HOME/.vim
ln -i -s $SCRIPT_DIR/.ctags $HOME/.ctags
ln -i -s $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -i -s $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -i -s $SCRIPT_DIR/.vrapperrc $HOME/.vrapperrc
ln -i -s $SCRIPT_DIR/.xvimrc $HOME/.xvimrc
ln -i -s $SCRIPT_DIR/.zshrc $HOME/.zshrc

mkdir $HOME/.config
ln -s $SCRIPT_DIR/vim $HOME/.config/nvim
touch $HOME/.vimrc.local
