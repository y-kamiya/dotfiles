#!/bin/bash -e

SCRIPT_DIR=$(cd $(dirname $0); pwd)

ln -iTs $SCRIPT_DIR/vim $HOME/.vim
ln -iTs $SCRIPT_DIR/.ctags $HOME/.ctags
ln -iTs $SCRIPT_DIR/.gitconfig $HOME/.gitconfig
ln -iTs $SCRIPT_DIR/.tmux.conf $HOME/.tmux.conf
ln -iTs $SCRIPT_DIR/.vrapperrc $HOME/.vrapperrc
ln -iTs $SCRIPT_DIR/.xvimrc $HOME/.xvimrc
ln -iTs $SCRIPT_DIR/.zshrc $HOME/.zshrc
ln -iTs $SCRIPT_DIR/.zprofile $HOME/.zprofile
ln -iTs $SCRIPT_DIR/.ideavimrc $HOME/.ideavimrc
ln -iTs $SCRIPT_DIR/.zshrc_env $HOME/.zshrc_env
ln -iTs $SCRIPT_DIR/.vimrc.local $HOME/.vimrc.local
ln -iTs $SCRIPT_DIR/.gitconfig.local $HOME/.gitconfig.local

mkdir -p $HOME/.config/mise/conf.d
ln -iTs $SCRIPT_DIR/mise_config.toml $HOME/.config/mise/conf.d/mise_config.toml 
ln -iTs $SCRIPT_DIR/vim $HOME/.config/nvim
touch $HOME/.vimrc.local

if ! command -v mise &>/dev/null; then
    curl https://mise.run | sh
fi
mkdir -p $HOME/.local/bin
export PATH="$HOME/.local/bin:$PATH"
mise install

bash vim/setup.sh


if [ ! -d $HOME/.tmux ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ -f $SCRIPT_DIR/setup_local.sh ]; then
    ./setup_local.sh
fi
