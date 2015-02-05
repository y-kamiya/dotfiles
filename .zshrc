bindkey -e

# git completion
if [ -d ~/.zsh/completion ]; then
    fpath=(~/.zsh/completion $fpath)
    autoload -U compinit
    compinit -u
fi

autoload zmv
alias zmv='noglob zmv -W '

# encode
export LANG=ja_JP.UTF-8

# cdを省略
setopt auto_cd

setopt extended_glob

# for brew
PATH=~/usr/local/bin:$PATH
# for haskell
PATH=$HOME/.cabal/bin:/Library/Haskell/bin:$PATH
function htags () { find . -name '*.*hs' | xargs hasktags -c -o .git/tags -R ; sort -o .git/tags .git/tags }

# aliasの設定
case ${OSTYPE} in
    darwin*)
        alias ls="ls -G"
        ;;
    linux*)
        alias ls="ls --color=auto"
        ;;
esac

alias la="ls -a"
alias ll="ls -l"
alias ivm="vim"

export de='develop'
export fo='forked'

# ssh-agent
#. ~/.keychain/$HOST-sh

exceptedFiles='compiled_*'
function find-grep() { find . -print0 -type f ! -name $exceptedFiles -o -name .git -prune -o -name dist -prune -o -name build -prune | xargs -0 grep -n --binary-files=without-match "$@" 2> /dev/null }
function find:() { find . -name "$@" }
function getcol() { awk -v num=$1 '{print $num}' }
function gco() { git branch | grep $1 | xargs git checkout }
function gco-a() { git branch -a | grep $1 | grep remote | cut'/' -f3- | xargs git checkout }
function gd() { git branch | grep $1 | xargs git branch -D }

###############################################
##   プロンプトの表示設定                     #
################################################

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '(%b)'
precmd() {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	psvar[1]=$vcs_info_msg_0_
}

setopt prompt_subst
PROMPT="[%n@%m]%# "
RPROMPT="%F{blue}%1v%f%{[32m%}[%~]%{[m%}"

# tmux powerline
PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# ヒストリの設定
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000


if [ -f $HOME/.zshrc_env ]; then
    source $HOME/.zshrc_env
fi
