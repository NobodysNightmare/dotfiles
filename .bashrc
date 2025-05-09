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
HISTSIZE=10000
HISTFILESIZE=10000

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

. ~/.dotfiles/switch-aws-role.sh

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
source "$HOME/.asdf/asdf.sh"

export GOPATH="$HOME/go"

export PATH=$PATH:/usr/local/go/bin
export PATH="$GOPATH/bin:$PATH"

export PATH="~/.dotfiles/bin:$PATH"

alias be='bundle exec'
alias gti='git'
alias codegrep='grep -r --exclude *.log --exclude-dir .idea --exclude-dir .git --exclude-dir node_modules --exclude-dir tmp --exclude-dir coverage'

alias server='docker compose up frontend'
alias rd='docker compose run --rm worker'
alias rt='docker compose run --rm backend-test'
alias tt='timetrap display -f quota'

work_dir=$HOME/development/work
private_dir=$HOME/development/private
export CDPATH=".:$work_dir:$private_dir"

export KUBE_EDITOR=nano

source ~/.git-completion.sh

export STARSHIP_CONFIG=~/.dotfiles/starship.toml
eval "$(starship init bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.dotfiles/secrets.sh ] && source ~/.dotfiles/secrets.sh
