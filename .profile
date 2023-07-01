export XDG_CONFIG_HOME=$HOME/.config
VIM="nvim"
export GIT_EDITOR=$vim

PERSONAL=$XDG_CONFIG_HOME/personal
source $PERSONAL/env
for i in $(find -L $PERSONAL); do
	source $i
done

HWSETTINGS=$HOME/.hwsettings
for i in $(find -L $HWSETTINGS); do
	source $i
done

export GPG_TTY=$(tty)
export DOTFILES=$HOME/.dotfiles

. "$HOME/.cargo/env"
