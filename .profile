alias vim=nvim
alias la='exa -lar --icons'
export GPG_TTY=$(tty)

xrandr -s 1920x1080 -r 60

nitrogen --restore
. "$HOME/.cargo/env"

DOTFILES="$HOME/.dotfiles"

dotfiles () {
  git --git-dir="$DOTFILES" --work-tree="$HOME" "$@"
}
