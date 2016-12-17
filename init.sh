#!/bin/bash

ln -s ~/gws/dotfiles/.tmux.conf ~/.tmux.conf 
ln -s ~/gws/dotfiles/.zshrc     ~/.zshrc     
ln -s ~/gws/dotfiles/vim        ~/.vim       
ln -s ~/gws/dotfiles/.vimrc     ~/.vimrc     
ln -s ~/gws/dotfiles/.gitconfig ~/.gitconfig     

mkdir -p ~/.config
ln -s ~/.vim ~/.config/nvim

touch ~/.vimrc.local
touch ~/.gitconfig.local

mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
