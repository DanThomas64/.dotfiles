#!/bin/bash

# Install required apps
declare -a apps=(
	neovim
	fzf
	treesitter
	zsh
	exa
	bat
	stow
	github-cli
	zoxide
	btop
	tree
	tldr-page
	thefuck
	dust-git
	tmux
	lazygit
	ripgrep
)

for app in "${apps[@]}"; do
	yay -S ${app[@]} --noconfirm
done

# Download and deploy dotfile git repo.
DOTFILES="$HOME/.dotfiles"
URL="https://github.com/DanThomas64/.dotfiles/"
git clone $URL $DOTFILES
cd $DOTFILES
stow . --adopt
git restore .
cd $HOME

# Download and deploy nvim config
VIMRC="$HOME/.config/nvim"

if [[ -d "$VIMRC" ]]; then
	echo "Found old neovim config"
	echo "Checking for old backup"
	if [[ -d "${VIMRC}_backup" ]]; then
		echo "Found old backup, removing it"
		rm -rf "${VIMRC}_backup"
	fi
	echo "Moving the current config to a backup folder"
	mv "$VIMRC" "${VIMRC}_backup"
fi

git clone "DanThomas64/nvim.init" $VIMRC

# Install oh-my-zsh and set zsh as default
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

sudo chsh -s /usr/bin/zsh $USERNAME

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# MISC 

# Create Project Folder
if [[ ! -d "${HOME}/project" ]]; then
	mkdir "${HOME}/project"
fi

# Auth GitHub for further setup
gh auth login -w
