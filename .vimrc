let mapleader=" "

set rtp+=/usr/local/Cellar/go/1.3/libexec/misc/vim

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
NeoBundleLazy 'Shougo/unite.vim', {
    \ 'autoload': { 'commands': ['Unite'] }
\}
let s:bundle = neobundle#get("unite.vim")
function! s:bundle.hooks.on_source(bundle)
    NeoBundle 'Shougo/neomru.vim'
    let g:unite_source_grep_max_candidates = 200
    
    if executable('ag')
        " Use ag in unite grep source.
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_recursive_opt = 'HRn'
        let g:unite_source_grep_default_opts =
        \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    endif
endfunction
 
" unite prefix key
nnoremap [unite] <Nop>
nmap <Leader>f [unite]
" mappings
nnoremap [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap [unite]f :<C-u>Unite<Space>file<CR>
nnoremap [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap [unite]a :<C-u>Unite buffer file file_mru bookmark<CR>
nnoremap [unite]r :<C-u>Unite<Space>register<CR>
nnoremap [unite]R :<C-u>UniteResume<CR>
let g:unite_enable_start_insert=1

" }}}
" {{{ neocomplcache
NeoBundle 'Shougo/neocomplcache'
let s:bundle = neobundle#get("neocomplcache")
function! s:bundle.hooks.on_source(bundle)
  let g:neocomplcache_enable_at_startup = 1
	let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_max_list = 5
endfunction
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
NeoBundleLazy 'dag/vim2hs', { 'autoload': {'filetypes': ['haskell']} }
" disable all conceals, including the simple ones like
" " lambda and composition
let s:bundle = neobundle#get("vim2hs")
function! s:bundle.hooks.on_source(bundle)
  let g:haskell_conceal      = 0
endfunction

"NeoBundleLazy 'pbrisbin/html-template-syntax', { 'autoload': {'filetypes': ['haskell']} }
NeoBundleLazy 'eagletmt/neco-ghc'            , { 'autoload': {'filetypes': ['haskell']} }
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
NeoBundleLazy 'eagletmt/ghcmod-vim'          , { 'autoload': {'filetypes': ['haskell']} }
NeoBundleLazy 'thinca/vim-ref'               , { 'autoload': {'filetypes': ['haskell']} }
NeoBundleLazy 'ujihisa/ref-hoogle'           , { 'autoload': {'filetypes': ['haskell']} }
NeoBundleLazy 'ujihisa/unite-haskellimport'  , { 'autoload': {'filetypes': ['haskell']} }
nnoremap <buffer> <space>I :<C-u>UniteWithCursorWord haskellimport<Cr>
" for html coding
"NeoBundleLazy 'mattn/zencoding-vim'     , { 'autoload': {'filetypes': ['html, php, hamlet']} }
" for js syntax
NeoBundleLazy 'pangloss/vim-javascript' , { 'autoload': {'filetypes': ['js']} }
" for ejs syntax
NeoBundleLazy 'briancollins/vim-jst'    , { 'autoload': {'filetypes': ['js']} }
" syntax checker using various tools
NeoBundle 'scrooloose/syntastic'
" }}}
" {{{ vim-indent-guides
" NeoBundle 'nathanaelkane/vim-indent-guides'
"let g:indent_guides_enable_on_vim_startup = 1
"let g:indent_guides_guide_size = 1
" }}}
"{{{ vim-fugitive
NeoBundleLazy 'tpope/vim-fugitive', { 
      \'autoload': {'commands': ['Gblame']}, 
      \'augroup' : 'fugitive',
      \}
let s:bundle = neobundle#get('vim-fugitive')
function! s:bundle.hooks.on_post_source(bundle)
    doautoall fugitive BufNewFile
endfunction
NeoBundle 'tpope/vim-surround'
NeoBundle 'tComment'
NeoBundle 'tpope/vim-abolish'
NeoBundle 'vim-scripts/gtags.vim'
"}}}
" {{{ vim-php-cs-fixer, vdebug
let s:fixer = expand('~/app/vendor/bin/php-cs-fixer')
if executable(s:fixer)
    NeoBundleLazy 'joonty/vdebug'            , { 'autoload': {'commands': ['php']} } 
    NeoBundleLazy 'stephpy/vim-php-cs-fixer' , { 'autoload': {'commands': ['php']} } 
    let g:php_cs_fixer_path = s:fixer
endif
" }}}
" {{{ buftabs
"NeoBundle 'buftabs'
"let buftabs_only_basename = 1
"let buftabs_in_statusline = 1
" }}}
" {{{colorschema
NeoBundle 'w0ng/vim-hybrid'
" }}}
" {{{yanktmp
NeoBundle 'vim-scripts/yanktmp.vim'
nnoremap <silent> <Leader>ty :call YanktmpYank()<CR>
nnoremap <silent> <Leader>tp :call YanktmpPaste_p()<CR>
nnoremap <silent> <Leader>tP :call YanktmpPaste_P()<CR>
" }}}
"NeoBundle 'chazmcgarvey/vimcoder'
"
:source $VIMRUNTIME/macros/matchit.vim

filetype plugin indent on
syntax on


set termencoding=utf-8
" set fileencodings=iso-2021-jp-3,iso-2022-jp,euc-jisx0213,euc-jp,utf-8,ucs-bom,euc-jp,eucjp-ms,cp932
set title
set smartindent
"set backupdir=~/.vim/vimbackup
"set directory=~/.vim/vimbackup
set expandtab
set number
set smartcase
set smarttab
set wildmenu
set nobackup
set noswapfile
set lazyredraw
set laststatus=2
set statusline=%=[%{&enc}/%{&fenc}][%<%F\%m%w]
set showmatch
set hlsearch
set foldmethod=marker
set path+=~/gws/infra/ckvs_build/ckvs/**
set suffixesadd+=.php
set pastetoggle=<F9>
set shiftwidth=4
set tabstop=4
set tags=.git/tags,.tags,./tags,tags
set display=lastline
set pumheight=5


" 対応するカッコの表示をしない
let loaded_matchparen = 1

highlight CursorColumn term=reverse cterm=reverse


au BufRead,BufNewFile *.ctp set filetype=php
au BufRead,BufNewFile *.html set filetype=php
au BufRead,BufNewFile *.tpl set filetype=html
au BufRead,BufNewFile *.as set filetype=javascript

"au BufNewFile *.tpl 0r ~/.vim/template/template.tpl
"au BufNewFile *.tpl %substitute#__DATE__#\=strftime('%Y-%m-%d')#ge

" haskell
au BufRead,BufNewFile *.hs  set sw=2 ts=2
au BufRead,BufNewFile *.hamlet  setf hamlet
au BufRead,BufNewFile *.cassius setf cassius
au BufRead,BufNewFile *.lucius  setf lucius
au BufRead,BufNewFile *.julius  setf julius

" {{{  go
au BufRead,BufNewFile *.go set noexpandtab
au BufWritePre *.go Fmt
let g:gofmt_command = 'goimports'
set rtp+=${GOROOT}/misc/vim
set rtp^=${GOPATH}/src/github.com/nsf/gocode/vim
" }}}
" {{{ key mappings
inoremap <C-f> <Esc>

nnoremap Y y$

function! HighlightCursor()
    set cursorline
    set cursorcolumn
    redraw
    sleep 50ms
    set nocursorcolumn
    set nocursorline
    redraw
endfunction
nnoremap <silent> <C-l> :call HighlightCursor()<CR>
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


" search selected strings in visual mode
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch()
    let tmp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
    let @s = tmp
endfunction

" show cursor position toggle
nnoremap <silent> <Leader>c :<C-u>setlocal cursorcolumn! cursorline!<CR>
nnoremap <silent> <Leader>h :GhcModCheckAndLintAsync<CR>
" }}}
" {{{ colorschema
autocmd ColorScheme * highlight LineNr ctermfg=239
set background=dark
"let g:solarized_termtrans=1
"colorscheme solarized
colorscheme hybrid
" }}}

