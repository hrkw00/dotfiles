export LC_ALL=en_US.UTF-8

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:$MANPATH

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

export PATH=/usr/local/opt/mysql@5.7/bin:$PATH

# export PATH=$HOME/bin:/usr/local/bin:$PATH
# export ZSH=$HOME/.oh-my-zsh
# ZSH_THEME="cobalt2"
# 
# source $ZSH/oh-my-zsh.sh

# rbenv PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# nodenv PATH
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# flutter PATH
export PATH="$PATH:`pwd`/flutter/bin"

# golang PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# allias
alias chrome="open -a 'Google Chrome'"
alias c="clear"
alias ../="cd ../"

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats 'on branch %b'
 
# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
PROMPT='%n in ${PWD/#$HOME/~} ${vcs_info_msg_0_} > '
