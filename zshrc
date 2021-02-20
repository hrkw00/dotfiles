export LC_ALL=en_US.UTF-8

eval "$(direnv hook zsh)"

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

# source $ZSH/oh-my-zsh.sh

# pyenv PATH
export PYENV_ROOT=${HOME}/.pyenv

if [ -d "${PYENV_ROOT}" ]; then
    export PATH=${PYENV_ROOT}/bin:$PATH
    eval "$(pyenv init -)"
fi

# rbenv PATH
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# nodenv PATH
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init -)"

# export PATH="$HOME/.nodenv/versions/*/bin:$PATH"

# export PATH="$HOME/.anyenv/envs/ndenv/versions/10.16.0/bin:$PATH"

# flutter PATH
export PATH="$PATH:`pwd`/flutter/bin"

# golang PATH
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# aws PATH
export PATH=~/.local/bin:$PATH

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# alias
alias chrome="open -a 'Google Chrome'"
alias c="clear"
alias ..="cd .."
alias pj="cd ~/Projects"
alias progate="cd ~/Projects/progate"
alias notes="cd ~/Notes"
alias tf="terraform"

# functions
replace_word () {
    grep -l $1 $3 | xargs sed -i -e "s/$1/$2/g"
}

find_password () {
    security find-generic-password -ga $1 | grep 'password:'
}

create_localhost () {
    python -m SimpleHTTPServer $1 --bind
}

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
zstyle ':vcs_info:git:*' formats '%b'

function show-git-branch-with-color {
  local branch_name st branch_status

  if [ ! -e  ".git" ]; then
    return
  fi
  branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    branch_status="%F{blue}"
  elif [[ -n `echo "$st" | grep "^Untracked files"` ]]; then
    branch_status="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes not staged for commit"` ]]; then
    branch_status="%F{red}"
  elif [[ -n `echo "$st" | grep "^Changes to be committed"` ]]; then
    branch_status="%F{green}"
  elif [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
    echo "%F{red}!(no branch)"
    return
  else
    branch_status="%F{blue}"
  fi
  echo "${branch_status}${vcs_info_msg_0_}%f"
}

# show status emoji

function show-status-emoji {
  if [ $? -eq 0 ]; then
    echo "（⌒ ▽ ⌒ ）"
  else
    echo "(T＿T)"
  fi
}

# Set up the prompt (with git branch name)
setopt PROMPT_SUBST
# PROMPT=' `show-status-emoji` %F{yellow}${PWD/#$HOME/~}%f `show-git-branch-with-color`'
PROMPT='%F{yellow}${PWD/#$HOME/~}%f `show-status-emoji` `show-git-branch-with-color` $ '

# for complie
if [ ~/.zshrc -nt ~/.zshrc.zwc ]; then
  zcompile ~/.zshrc
fi

# for tmux
if [ $SHLVL = 1 ]; then
  tmux
fi

setopt inc_append_history
