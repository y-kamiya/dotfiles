if [ -f /opt/homebrew/bin/brew ];then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [ -f /home/linuxbrew/.linuxbrew/bin/brew ];then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

PATH=$HOME/bin:$PATH

if [ -d /usr/local/opt/coreutils/libexec/gnubin ]; then
    PATH='/usr/local/opt/coreutils/libexec/gnubin':$PATH
    MANPATH='/usr/local/opt/coreutils/libexec/gnuman':$MANPATH
fi

# for haskell
PATH=$HOME/.local/bin:$HOME/.cabal/bin:/Library/Haskell/bin:$PATH

# for uconv
if [ -d /usr/local/Cellar/icu4c/58.1/bin ]; then
    PATH=/usr/local/Cellar/icu4c/58.1/bin/:$PATH
fi

if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ]; then 
    source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
fi
