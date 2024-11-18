let pyver = system("python -V | awk '{split($2, a, \".\"); printf(\"%s%s\", a[1], a[2])}'")
let g:python3_host_prog = '$HOME/.vim/venv-python' . pyver . '/bin/python3'

execute 'source' fnamemodify(expand('<sfile>'), ':h').'/vimrc'
