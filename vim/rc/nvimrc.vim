tnoremap <ESC> <C-\><C-n>

command! -nargs=* T split | wincmd j | resize 20 | terminal <args>

autocmd TermOpen * startinsert
