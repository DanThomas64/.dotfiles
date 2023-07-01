#!/bin/bash

DOTFILES="$HOME/.dotfiles"
URL="https://github.com/DanThomas64/.dotfiles/"

dotfiles () {
  git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

git clone -b linux --bare $URL $DOTFILES
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout || echo -e 'Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ndtf checkout'

# Also should be used to install ZSH and OH-MY-ZSH exa neovim
# nodejs, perl, rust, 
