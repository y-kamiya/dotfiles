#!/bin/bash -xe

script_dir=$(cd `dirname $0`; pwd)
pushd $script_dir

if [ ! -d venv-python3 ]; then
    python3 -m venv venv-python3
fi

source venv-python3/bin/activate
pip install neovim pynvim
deactivate

popd
