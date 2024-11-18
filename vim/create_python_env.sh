#!/bin/bash -xe

script_dir=$(cd `dirname $0`; pwd)
pushd $script_dir

pyver=$(python -V | awk '{split($2, a, "."); printf("%s%s", a[1], a[2])}')
venv_dir=venv-python${pyver}
if [ ! -d $venv_dir ]; then
    python3 -m venv $venv_dir
fi

source $venv_dir/bin/activate
pip install neovim pynvim
deactivate

popd
