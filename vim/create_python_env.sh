#!/bin/bash -xe

script_dir=$(cd `dirname $0`; pwd)
pushd $script_dir

venv_dir=venv-python3
if [ ! -d $venv_dir ]; then
    python3 -m venv $venv_dir
fi

source $venv_dir/bin/activate
pip install neovim pynvim
deactivate

popd
