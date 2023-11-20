#!/bin/bash

mkdir -p $HOME/.local/bin

# install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

# install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
mv nvim-linux64 $HOME/.local/nvim

# install rg
rg_name=ripgrep-13.0.0-x86_64-unknown-linux-musl
curl -LO "https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/$rg_name.tar.gz"
tar xzf $rg_name.tar.gz
cp $rg_name/rg $HOME/.local/bin
rm -rf $rg_name $rg_name.tar.gz
