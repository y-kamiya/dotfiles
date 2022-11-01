bindkey -e

autoload -U compinit
compinit -u

autoload zmv
alias zmv='noglob zmv -W '

# encode
export LC_ALL=ja_JP.UTF-8

setopt extended_glob

# for haskell
function htags () { find . -name '*.*hs' | xargs hasktags -c -o .git/tags -R ; sort -o .git/tags .git/tags }

# alias
unalias ls > /dev/null 2>&1
ls --color=auto > /dev/null 2>&1
if [ $? -eq 0 ]; then
    alias ls="ls --color=auto"
else
    alias ls="ls -G"
fi

alias la="ls -a"
alias ll="ls -l"
alias ivm="vim"
alias va="vagrant"
alias cb="git rev-parse --abbrev-ref HEAD"

export de='develop'
export fo='forked'
export up='upstream'
export or='origin'
export XDG_CONFIG_HOME=$HOME/.config
export HOMEBREW_NO_AUTO_UPDATE=1

zle -la history-incremental-pattern-search-backward && bindkey "^r" history-incremental-pattern-search-backward
zle -la history-incremental-pattern-search-forward  && bindkey "^s" history-incremental-pattern-search-forward

if [ -f ~/.keychain/$HOST-sh ]; then
    keychain --nogui --quiet ~/.ssh/id_rsa
    keychain --nogui --quiet ~/.ssh/id_ed25519
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

if [ -f $HOME/.asdf/asdf.sh ]; then
    source $HOME/.asdf/asdf.sh
    FPATH=${ASDF_DIR}/completions:$FPATH
fi

if [ -f $HOME/.asdf/plugins/java/set-java-home.zsh ]; then
    source $HOME/.asdf/plugins/java/set-java-home.zsh
fi

if [ -f $HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh ]; then
    source $HOME/.asdf/plugins/dotnet-core/set-dotnet-home.zsh
fi

if type kubectl > /dev/null 2>&1; then
    source <(kubectl completion zsh)
fi

if [ -f /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc ]; then
    source /opt/homebrew/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

if [ -f $HOME/.zshrc_env ]; then
    source $HOME/.zshrc_env
fi

if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

FPATH=$HOME/.zsh/completion:$FPATH
