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
export LC_ALL=ja_JP.UTF-8

setopt auto_cd
setopt extended_glob

PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# for haskell
PATH=$HOME/.local/bin:$HOME/.cabal/bin:/Library/Haskell/bin:$PATH
function htags () { find . -name '*.*hs' | xargs hasktags -c -o .git/tags -R ; sort -o .git/tags .git/tags }

# alias
function ls_type() {
    case ${OSTYPE} in
        darwin*)
            HAS_COREUTILS=$(brew list | grep '^coreutils$' | wc -l)
            if [ 0 -eq $HAS_COREUTILS ]; then
                echo 'darwin'
            else
                echo 'linux'
            fi ;;
        linux*) echo 'linux';;
    esac
}
case `ls_type` in
    darwin) alias ls="ls -G";;
    linux)  alias ls="ls --color=auto";;
    *) echo 'unknown type is found, `ls` has no color now'
esac

alias la="ls -a"
alias ll="ls -l"
alias ivm="vim"
alias va="vagrant"
alias cb="git rev-parse --abbrev-ref HEAD"

export de='develop'
export fo='forked'
export up='upstream'
export XDG_CONFIG_HOME=$HOME/.config

zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
zle -la history-incremental-pattern-search-forward  && bindkey "^s" history-incremental-pattern-search-forward

if [ -f ~/.keychain/$HOST-sh ]; then
    keychain --nogui --quiet ~/.ssh/id_rsa
    source ~/.keychain/$HOST-sh
fi

exceptedFiles='compiled_* db'
function find-grep() { find . -print0 -type f ! -name $exceptedFiles -o -name .git -prune -o -name dist -prune -o -name build -prune | xargs -0 grep -n --binary-files=without-match "$@" 2> /dev/null }
function find:() { find . -name "$@" }
function getcol() { awk -v num=$1 '{print $num}' }
function gco() { git branch | grep $1 | xargs git checkout }
function gco-a() { git branch -a | grep $1 | grep remote | cut'/' -f3- | xargs git checkout }
function gd() { git branch | grep $1 | xargs git branch -D }

# prompt
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

# history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# settings for pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

if [ -f $HOME/.zshrc_env ]; then
    source $HOME/.zshrc_env
fi

