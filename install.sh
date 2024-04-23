#!/bin/bash

# Install required apps
declare -a apps=(
	alacritty
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
	discord
	remmina
	freerdp
	tree
	tldr-page
	thefuck
	dust-git
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

# Auth GitHub for further setup
gh auth login -w

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

gh repo clone "DanThomas64/nvim.init" $VIMRC

# Install hack Font
if fc-match "Hack" &>/dev/null; then
	declare -a fonts=(
		Hack
	)

	version='3.2.1'
	fonts_dir="${HOME}/.local/share/fonts"

	if [[ ! -d "$fonts_dir" ]]; then
		mkdir -p "$fonts_dir"
	fi

	for font in "${fonts[@]}"; do
		zip_file="${font}.zip"
		download_url="https://github.com/ryanoasis/nerd-fonts/releases/download/v${version}/${zip_file}"
		echo "Downloading $download_url"
		wget "$download_url"
		unzip "$zip_file" -d "$fonts_dir" -x "*.txt/*" -x "*.md/*"
		rm "$zip_file"
	done

	find "$fonts_dir" -name '*Windows Compatible*' -delete

	fc-cache -fv
else
    echo "Hack is already installed."
fi

# Install oh-my-zsh and set zsh as default
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

sudo chsh -s /usr/bin/zsh $USERNAME

git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# MISC 

# Create Screenshot Folder

if [[ ! -d "${HOME}/Pictures/screenshots" ]]; then
	mkdir "${HOME}/Pictures/screenshots"
fi
