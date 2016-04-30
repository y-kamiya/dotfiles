if exists("did_load_filetypes")
      finish
  endif

augroup filetypedetect
  autocmd BufRead,BufNewFile *.ctp set filetype=php
  autocmd BufRead,BufNewFile *.html set filetype=php
  autocmd BufRead,BufNewFile *.tpl set filetype=html
  autocmd BufRead,BufNewFile *.as set filetype=javascript
  autocmd BufRead,BufNewFile *.hs  set filetype=haskell
  autocmd BufRead,BufNewFile *.hamlet  set filetype=hamlet
  autocmd BufRead,BufNewFile *.cassius set filetype=cassius
  autocmd BufRead,BufNewFile *.lucius  set filetype=lucius
  autocmd BufRead,BufNewFile *.julius  set filetype=julius
  autocmd BufRead,BufNewFile *.md  set filetype=markdown
augroup END


