#!/bin/bash -xe

SCRIPT_DIR=$(cd $(dirname $0); pwd)

DPP_BASE=$SCRIPT_DIR/dpp/repos/github.com
if [ ! -d $DPP_BASE/Shougo/dpp.vim ]; then
    git clone https://github.com/Shougo/dpp.vim           $DPP_BASE/Shougo/dpp.vim
    git clone https://github.com/Shougo/dpp-ext-toml      $DPP_BASE/Shougo/dpp-ext-toml
    git clone https://github.com/Shougo/dpp-ext-lazy      $DPP_BASE/Shougo/dpp-ext-lazy
    git clone https://github.com/Shougo/dpp-ext-installer $DPP_BASE/Shougo/dpp-ext-installer
    git clone https://github.com/Shougo/dpp-protocol-git  $DPP_BASE/Shougo/dpp-protocol-git
    git clone https://github.com/vim-denops/denops.vim    $DPP_BASE/vim-denops/denops.vim
fi

bash $SCRIPT_DIR/create_python_env.sh
