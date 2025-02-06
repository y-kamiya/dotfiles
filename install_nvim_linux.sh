#!/bin/bash

mkdir -p $HOME/.local/bin

# install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

# install nvim
name=nvim-linux-x86_64
tar=$name.tar.gz
if [ -z $tar ]; then
    curl -LO https://github.com/neovim/neovim/releases/download/stable/$tar
fi
tar xzf $tar
mv $name $HOME/.local/nvim

# install rg
rg_name=ripgrep-13.0.0-x86_64-unknown-linux-musl
curl -LO "https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/$rg_name.tar.gz"
tar xzf $rg_name.tar.gz
cp $rg_name/rg $HOME/.local/bin
rm -rf $rg_name $rg_name.tar.gz
