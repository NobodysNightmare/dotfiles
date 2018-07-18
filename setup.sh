#!/bin/bash
set -e

export DOTFILES=`dirname "$0"`
export DOTFILES=`readlink -f "$DOTFILES"`

if [ ! -d "$HOME/.rbenv" ]; then
  echo "Installing rbenv..."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
  git clone https://github.com/rbenv/rbenv-each.git ~/.rbenv/plugins/rbenv-each
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

if [ ! -e "$HOME/.git-completion.sh" ]; then
  echo "Downloading git completion..."
  wget -O "$HOME/.git-completion.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi
