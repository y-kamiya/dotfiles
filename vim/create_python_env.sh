#!/bin/sh

script_dir=$(cd `dirname $0`; pwd)
pushd $script_dir

python3 -m venv venv-python3

source venv-python3/bin/activate
pip install neovim pynvim
deactivate

popd
