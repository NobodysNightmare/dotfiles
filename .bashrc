# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH=$PATH:/usr/local/go/bin
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

export PATH="~/.dotfiles/bin:$PATH"

alias be='bundle exec'
alias gti='git'
alias bundle-audit-fix='~/development/aroundhome/kaeuferportal/command_line_tools_kp/bin/bundle-audit-fix'

alias codegrep='grep -r --exclude *.log --exclude-dir .idea --exclude-dir .git --exclude-dir node_modules --exclude-dir tmp --exclude-dir coverage'

alias rd='docker-compose run --rm development'
alias rt='docker-compose run --rm test'
alias server='bin/server'
alias tt='timetrap display -f quota'

export AWS_PROFILE=legacy
export PROMPT_DIRTRIM=2

aroundhome_dirs=$(ls -d /home/jan/development/aroundhome/* | tr '\n' ':' | sed 's/.$//')
private_dirs=/home/jan/development/private
export CDPATH=".:$aroundhome_dirs:$private_dirs"

export GIT_PS1_SHOWCOLORHINTS=1
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINT=1
source ~/.git-completion.sh
export PROMPT_COMMAND='__git_ps1 "\[\e[2m\]\A\[\e(B\e[m\] \w" "\\\$ "; echo -ne "\033]0;$(pwd | rev | cut -d "/" -f 1 | rev) @${HOSTNAME}\007"'

[ -f "$HOME/.travis/travis.sh" ] && source "$HOME/.travis/travis.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH=~/.npm-global/bin:$PATH
nvm use --silent
