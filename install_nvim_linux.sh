#!/bin/bash

# install deno
curl -fsSL https://deno.land/x/install/install.sh | sh

# install nvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
tar xzf nvim-linux64.tar.gz
mv nvim-linux64 $HOME/.local/nvim
