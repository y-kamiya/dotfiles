let mapleader=" "

set rtp+=/usr/local/Cellar/go/1.3/libexec/misc/vim

augroup myvimrc
    autocmd!
augroup END

" {{{ NeoBundle basic setting
set nocompatible
filetype off

if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
call neobundle#begin(expand('~/.vim/bundle/'))

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
NeoBundleLazy 'Shougo/unite.vim',  { 'autoload': { 'commands': ['Unite'] } }
NeoBundle 'Shougo/neomru.vim'
let s:bundle = neobundle#get("unite.vim")
function! s:bundle.hooks.on_source(bundle)
    " let g:unite_source_grep_max_candidates = 200
    let g:unite_enable_start_insert = 0
    let g:unite_source_bookmark_directory = expand('~/.unite/bookmark')

    " call unite#custom_default_action('source/bookmark/directory' , 'vimfiler')

    autocmd myvimrc FileType unite imap <silent><buffer> <C-f> <Plug>(unite_insert_leave)

    if executable('ag')
        " Use ag in unite grep source.
        let g:unite_source_grep_command = 'ag'
        let g:unite_source_grep_recursive_opt = ''
        let g:unite_source_grep_default_opts =
        \ '--line-numbers --nocolor --nogroup --hidden --ignore ' .
        \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
    endif
endfunction
unlet s:bundle

" unite prefix key
nnoremap [unite] <Nop>
nmap <Leader>u [unite]
" mappings
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]c :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]y :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]a :<C-u>Unite buffer file file_mru bookmark<CR>
nnoremap <silent> [unite]R :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]r :<C-u>UniteResume search-buffer<CR>
nnoremap <silent> [unite]g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>


" }}}
" {{{ vimfiler
NeoBundle 'Shougo/vimfiler', {
    \ 'depends': ['Shougo/unite.vim'],
    \ 'autoload': { 'commands': ['VimFilerBufferDir'] },
    \}
let s:bundle = neobundle#get("vimfiler")
function! s:bundle.hooks.on_source(bundle)
    let vimfiler_as_default_explorer = 1
endfunction
" vimfiler prefix key
nnoremap [vimfiler] <Nop>
nmap <Leader>f [vimfiler]
noremap <silent> [vimfiler] :VimFilerBufferDir -split -simple -winwidth=40 -no-quit<CR>
" }}}
" {{{ neocomplcache
NeoBundle 'Shougo/neocomplcache'
let s:bundle = neobundle#get("neocomplcache")
function! s:bundle.hooks.on_source(bundle)
  let g:neocomplcache_enable_at_startup = 1
  let g:neocomplcache_enable_smart_case = 1
  let g:neocomplcache_max_list = 5
endfunction
unlet s:bundle
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
autocmd myvimrc FileType haskell setlocal omnifunc=necoghc#omnifunc
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
NeoBundle 'tpope/vim-fugitive'
" NeoBundleLazy 'tpope/vim-fugitive', {
"       \'autoload': {'commands': ['Gblame', 'Gedit']},
"       \'augroup' : 'myvimrc',
"       \}
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
" let s:fixer = expand('~/app/vendor/bin/php-cs-fixer')
" if executable(s:fixer)
    NeoBundleLazy 'joonty/vdebug'            , { 'autoload': {'filetypes': ['php']} }
    let g:vdebug_options = {
    \   'path_maps': { '/synced_folders/rpg-server': '/usr/local/funzio/cc-server' }
    \ , 'ide_key': ''
    \}
    " NeoBundleLazy 'stephpy/vim-php-cs-fixer' , { 'autoload': {'commands': ['php']} }
    " let g:php_cs_fixer_path = s:fixer
" endif
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
" {{{ag
NeoBundle 'rking/ag.vim'
" }}}
" {{{vimshell
NeoBundle 'Shougo/vimshell.vim', {
    \   'autoload' : { 'commands' : [ 'VimShellBufferDir', 'VimShellInteractive' ] },
    \   'depends': [ 'Shougo/vimproc' ],
    \}
" vimfiler prefix key
nnoremap [vimshell] <Nop>
nmap <Leader>s [vimshell]
nnoremap <silent> [vimshell] :VimShellBufferDir<CR>
nnoremap <silent> [vimshell]h :VimShellInteractive ghci<CR>
nnoremap <silent> [vimshell]s <S-v>:VimShellSendString<CR>
" }}}
" {{{vim-easy-align
NeoBundle 'junegunn/vim-easy-align'
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" }}}
" {{{memolist.vim
NeoBundleLazy 'glidenote/memolist.vim', {
    \ 'autoload': { 'commands': ['MemoNew','MemoList','MemoGrep'] }
    \}
let s:bundle = neobundle#get("memolist.vim")
function! s:bundle.hooks.on_source(bundle)
    let g:memolist_vimfiler = 1
    let g:memolist_path = expand('~/.memo')
endfunction
unlet s:bundle
nnoremap <Leader>mn  :MemoNew<CR>
nnoremap <Leader>ml  :MemoList<CR>
nnoremap <Leader>mg  :MemoGrep<CR>
" }}}
" {{{ctrlp.vim
NeoBundle 'ctrlpvim/ctrlp.vim'
let g:ctrlp_map = '<Leader>p'
" }}}
" {{{quickrun.vim
NeoBundleLazy 'thinca/vim-quickrun', {
    \ 'autoload': { 'commands': ['QuickRun'], 'mappings': '<Plug>' }
    \}
let s:bundle = neobundle#get("vim-quickrun")
function! s:bundle.hooks.on_source(bundle)
    let g:quickrun_config = {
    \   '_': {
    \     'debug': 'ss',
    \     'input': '=%{b:input}', 'cmdopt': '%{b:cmdopt}', 'args': '%{b:args}',
    \     'runner': 'vimproc',
    \     'runner/vimproc/updatetime': 50,
    \     'outputter/buffer/close_on_empty' : 1,
    \   },
    \   'haskell': {
    \       'command': 'runghc',
    \   },
    \}
endfunction
unlet s:bundle
nmap <silent> <Leader>rr <Plug>(quickrun)
" }}}
" {{{linediff.vim
NeoBundleLazy 'AndrewRadev/linediff.vim', { 
    \ 'autoload': { 'commands': ['Linediff'] }
    \}
" }}}
" {{{switch.vim
NeoBundleLazy 'AndrewRadev/switch.vim', { 
    \ 'autoload': { 'commands': ['Switch'] }
    \}
let g:switch_mapping = ''
" switch single quoto to double
let g:switch_custom_definitions = [
\   {
\       '''\(\k\+\)''': '"\1"',
\       '"\(\k\+\)"': '''\1''',
\   },
\]
" switch snake case to camel case
let g:variable_style_switch_definitions = [
\   {
\     '\<[a-z0-9]\+_\k\+\>': {
\       '_\(.\)': '\U\1'
\     },
\     '\<[a-z0-9]\+[A-Z]\k\+\>': {
\       '\([A-Z]\)': '_\l\1'
\     },
\   }
\]
nnoremap [switch.vim] <Nop>
nmap <Leader>sw [switch.vim]
nnoremap <silent> [switch.vim] :Switch<CR>
nnoremap <silent> [switch.vim]w :call switch#Switch(g:variable_style_switch_definitions)<CR>
" }}}
" {{{vim-submode
NeoBundleLazy 'kana/vim-submode', {
    \ 'autoload': { 'mappings': ['<C-w>>', '<C-w><', '<C-w>+', '<C-w>-'] }
    \}
let s:bundle = neobundle#get("vim-submode")
function! s:bundle.hooks.on_source(bundle)
    call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
    call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
    call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>+')
    call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>-')
    call submode#map('winsize', 'n', '', '>', '<C-w>>')
    call submode#map('winsize', 'n', '', '<', '<C-w><')
    call submode#map('winsize', 'n', '', '+', '<C-w>+')
    call submode#map('winsize', 'n', '', '-', '<C-w>-')
endfunction
" }}}
" {{{vim-choosewin
NeoBundleLazy 't9md/vim-choosewin', {
    \ 'autoload': { 'mappings': ['<Plug>'] }
    \}
nmap  <Leader>w  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1
let g:choosewin_overlay_clear_multibyte = 1
let g:choosewin_color_overlay = {
      \ 'gui': ['DodgerBlue3', 'DodgerBlue3' ],
      \ 'cterm': [ 25, 25 ]
      \ }
let g:choosewin_color_overlay_current = {
      \ 'gui': ['firebrick1', 'firebrick1' ],
      \ 'cterm': [ 124, 124 ]
      \ }
let g:choosewin_blink_on_land      = 0
let g:choosewin_statusline_replace = 0
let g:choosewin_tabline_replace    = 0
" }}}
" {{{vim-scala
NeoBundleLazy 'derekwyatt/vim-scala', {
    \ 'autoload': {'filetypes': ['scala']}
    \}
autocmd myvimrc BufNewFile,BufRead *.scala setf scala

" }}}
"NeoBundle 'chazmcgarvey/vimcoder'

" experiments
" {{{vim-expand-region.vim
" NeoBundle 'terryma/vim-expand-region'
" }}}

" my plugins
" {{{automkdir
NeoBundle "y-kamiya/automkdir.vim"
" }}}

call neobundle#end()
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
" set path+=~/gws/infra/ckvs_build/ckvs/**
set suffixesadd+=.php
set pastetoggle=<F9>
set shiftwidth=4
set tabstop=4
set tags=.git/tags,.tags,./tags,tags
set display=lastline
set pumheight=5
set virtualedit+=block


" 対応するカッコの表示をしない
let loaded_matchparen = 1

highlight CursorColumn term=reverse cterm=reverse

augroup myvimrc
    autocmd BufRead,BufNewFile *.ctp set filetype=php
    autocmd BufRead,BufNewFile *.html set filetype=php
    autocmd BufRead,BufNewFile *.tpl set filetype=html
    autocmd BufRead,BufNewFile *.as set filetype=javascript

    "autocmd BufNewFile *.tpl 0r ~/.vim/template/template.tpl
    "autocmd BufNewFile *.tpl %substitute#__DATE__#\=strftime('%Y-%m-%d')#ge

    " haskell
    autocmd BufRead,BufNewFile *.hs  setlocal sw=2 ts=2
    autocmd BufRead,BufNewFile *.hamlet  setf hamlet
    autocmd BufRead,BufNewFile *.cassius setf cassius
    autocmd BufRead,BufNewFile *.lucius  setf lucius
    autocmd BufRead,BufNewFile *.julius  setf julius

    " autocmd BufWritePre * %s/\s\+$//e
augroup END

" {{{  go
autocmd myvimrc BufRead,BufNewFile *.go set noexpandtab
autocmd myvimrc BufWritePre *.go Fmt
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
nnoremap <silent> <C-l> :noh<CR>:call HighlightCursor()<CR>
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
autocmd myvimrc ColorScheme * highlight LineNr ctermfg=239
set background=dark
"let g:solarized_termtrans=1
"colorscheme solarized
colorscheme hybrid
" }}}

