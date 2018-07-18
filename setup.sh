#!/bin/bash
set -e

# rbenv
if [ ! -d "$HOME/.rbenv" ]; then
  echo "Installing RVM..."
  git clone https://github.com/rbenv/rbenv.git ~/.rbenv
  cd ~/.rbenv && src/configure && make -C src
  mkdir -p ~/.rbenv/plugins
  $ git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
fi
