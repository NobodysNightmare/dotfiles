#!/bin/bash
set -e

export DOTFILES=`dirname "$0"`
export DOTFILES=`readlink -f "$DOTFILES"`

# rbenv
if [ ! -d "$HOME/.rbenv" ]; then
  echo "Installing RVM..."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir -p ~/.rbenv/plugins
  $ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi

function link_file {
  if [ ! -L "$HOME/$1" ]; then
    echo "Creating $1..."
    [ -e "$HOME/$1" ] && rm "$HOME/$1"
    ln -s "$DOTFILES/$1" "$HOME/$1"
  fi
}

link_file ".bashrc"
link_file ".gemrc"
link_file ".gitconfig"
link_file ".gitignore"
link_file ".vimrc"
