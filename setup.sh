#!/bin/bash
set -e

export DOTFILES=`dirname "$0"`
export DOTFILES=`readlink -f "$DOTFILES"`

if [ ! -L "$HOME/.dotfiles" ]; then
  echo "Creating symlink for dotfiles folder..."
  [ -e "$HOME/.dotfiles" ] && rm "$HOME/.dotfiles"
  ln -s "$DOTFILES" "$HOME/.dotfiles"
fi

if [ ! -d "$HOME/.rbenv" ]; then
  echo "Installing rbenv..."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir -p ~/.rbenv/plugins
  git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
  git clone https://github.com/rbenv/rbenv-vars.git ~/.rbenv/plugins/rbenv-vars
  git clone https://github.com/rbenv/rbenv-each.git ~/.rbenv/plugins/rbenv-each
fi

function link_simple {
  if [ ! -L "$HOME/$1" ]; then
    echo "Creating $1..."
    [ -e "$HOME/$1" ] && rm "$HOME/$1"
    ln -s "$DOTFILES/$1" "$HOME/$1"
  fi
}

function link_src_dest {
  SRC=$1
  DEST=$2

  if [ ! -L "$DEST" ]; then
    echo "Creating $DEST..."
    [ -e "$DEST" ] && rm "$DEST"

    mkdir -p $(dirname $DEST)
    ln -s "$DOTFILES/$SRC" "$DEST"
  fi
}

link_simple ".bashrc"
link_simple ".gemrc"
link_simple ".gitattributes"
link_simple ".gitconfig"
link_simple ".gitignore"
link_simple ".vimrc"

link_src_dest "jira-config.yml" "$HOME/.jira.d/config.yml"
link_src_dest "vscode/settings.json" "$HOME/.config/Code/User/settings.json"
link_src_dest "vscode/snippets" "$HOME/.config/Code/User/snippets"

if [ ! -e "$HOME/.git-completion.sh" ]; then
  echo "Downloading git completion..."
  wget -O "$HOME/.git-completion.sh" https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
fi

if [ -z "$(which starship)" ]; then
  echo "Installing starship..."
  sudo snap install starship
fi
