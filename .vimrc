set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif

NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }
" original repos on github 
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'tpope/vim-surround'
NeoBundle 'chazmcgarvey/vimcoder'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/gtags.vim'

" for haskell
NeoBundle 'dag/vim2hs'
NeoBundle 'pbrisbin/html-template-syntax'
NeoBundle 'eagletmt/neco-ghc'
NeoBundle 'eagletmt/ghcmod-vim'
" for html coding
NeoBundle 'mattn/zencoding-vim'
" for js syntax
NeoBundle 'pangloss/vim-javascript'
" for ejs syntax
NeoBundle 'briancollins/vim-jst'
" syntax checker using various tools
NeoBundle 'scrooloose/syntastic'
" NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'tpope/vim-fugitive'
" vim-scripts repos
NeoBundle 'tComment'
NeoBundle 'buftabs'
NeoBundle 'gtags'
" non github repos
filetype plugin indent on
syntax on



set termencoding=utf-8
" set fileencodings=iso-2021-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,utf-8,ucs-bom,euc-jp,eucjp-ms,cp932
set title
set smartindent
set backupdir=~/.vim/vimbackup
set directory=~/.vim/vimbackup
set expandtab
set number
set shiftwidth=4
set smartcase
set smarttab
set tabstop=4
set wildmenu
set laststatus=2
set statusline=%=[%{&enc}/%{&fenc}][%<%F\%m%w]
set showmatch
set hlsearch
set foldmethod=marker
set path+=~/hs/**,~/gws/poipoi/poipoi_enchant/**

au BufRead,BufNewFile *.ctp set filetype=php
au BufRead,BufNewFile *.html set filetype=php
au BufRead,BufNewFile *.tpl set filetype=html
au BufRead,BufNewFile *.as set filetype=javascript

au BufNewFile *.tpl 0r ~/.vim/template/template.tpl
au BufNewFile *.tpl %substitute#__DATE__#\=strftime('%Y-%m-%d')#ge

" haskell 
au BufRead,BufNewFile *.hamlet  setf hamlet
au BufRead,BufNewFile *.cassius setf cassius
au BufRead,BufNewFile *.lucius  setf lucius
au BufRead,BufNewFile *.julius  setf julius

" key mappings
inoremap <C-f> <Esc>

nnoremap <silent> tc :tabnew<CR>
nnoremap <silent> tk :tabclose<CR>
nnoremap <silent> ]t :tabnext<CR>
nnoremap <silent> [t :tabprevious<CR>

nnoremap <silent> bk :bd<CR>
nnoremap <silent> ]b :bn<CR>
nnoremap <silent> [b :bp<CR>
vnoremap < <gv
vnoremap > >gv

nnoremap <F6> :<C-u>source $MYVIMRC<CR>
nnoremap vim :<C-u>edit $MYVIMRC<CR>

" move view point to center when search words
nnoremap n nzz
nnoremap N Nzz


" setting in each plugin
" buftabs
let buftabs_only_basename = 1
let buftabs_in_statusline = 1

" indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1 

" unite.vim
nnoremap <Space>u :Unite buffer file file_mru bookmark<CR>
nnoremap <Space>c :Unite colorscheme<CR>

" neocomplcache.vim
let g:neocomplcache_enable_at_startup = 1

" 対応するカッコの表示をしない
let loaded_matchparen = 1

highlight CursorColumn term=reverse cterm=reverse



" lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ }
      \ }

" colorschema
set background=dark
"let g:solarized_termtrans=1
colorscheme hybrid





