" {{{ NeoBundle basic setting
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#rc(expand('~/.vim/bundle/'))
endif
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
    \ 'windows' : 'make -f make_mingw32.mak',
    \ 'cygwin' : 'make -f make_cygwin.mak',
    \ 'mac' : 'make -f make_mac.mak',
    \ 'unix' : 'make -f make_unix.mak',
  \ },
\ }
" }}}
" {{{ unite
NeoBundle 'Shougo/unite.vim'
" }}}
" {{{ neocomplcache
NeoBundle 'Shougo/neocomplcache'
let g:neocomplcache_enable_at_startup = 1
" }}}
" {{{ lightline
NeoBundle 'itchyny/lightline.vim'
" lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"⭤":""}',
      \ }
      \ }
" }}}
" {{{ syntax color and check
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
" }}}
" {{{ vim-indent-guides
" NeoBundle 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size = 1
" }}}
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'chazmcgarvey/vimcoder'
NeoBundle 'vim-scripts/gtags.vim'
"NeoBundle 'joonty/vdebug'
" {{{ vim-php-cs-fixer
let s:fixer = expand('~/app/vendor/bin/php-cs-fixer')
if executable(s:fixer)
    NeoBundle 'stephpy/vim-php-cs-fixer'
    let g:php_cs_fixer_path = s:fixer
endif
" }}}

NeoBundle 'tComment'
" {{{ buftabs
"NeoBundle 'buftabs'
"let buftabs_only_basename = 1
"let buftabs_in_statusline = 1
" }}}
:source $VIMRUNTIME/macros/matchit.vim

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
set path+=~/hs/**,~/gws/poipoi_enchant_self/**
set suffixesadd+=.php
set pastetoggle=<F9>


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

" {{{ key mappings
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

" unite
nnoremap <Space>u :Unite buffer file file_mru bookmark<CR>
nnoremap <Space>c :Unite colorscheme<CR>
" }}}

" 対応するカッコの表示をしない
let loaded_matchparen = 1

highlight CursorColumn term=reverse cterm=reverse


" {{{ colorschema
set background=dark
"let g:solarized_termtrans=1
colorscheme hybrid
" }}}

xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let tmp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = tmp
endfunction
