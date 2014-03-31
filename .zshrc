bindkey -e

alias j="$HOME/.autojump/bin/autojump"
[[ -s ~/.autojump/etc/profile.d/autojump.zsh ]] && . ~/.autojump/etc/profile.d/autojump.zsh

#autoload -U compinit
#compinit
autoload zmv
alias zmv='noglob zmv -W '

# encode
export LANG=ja_JP.UTF-8

# cdを省略
setopt auto_cd

# for brew
PATH=/usr/local/bin:$PATH

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

# ssh-agent
#. ~/.keychain/$HOST-sh

exceptedFiles='compiled_* .git'
function find-grep() { find . -type f ! -name $exceptedFiles | xargs grep -n --binary-files=without-match $@ }
function find:() { find . -name "$@" }
function col() { awk -v num=$1 '{print $num}' }
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
