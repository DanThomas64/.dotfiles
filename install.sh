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
	cp "$VIMRC" "${VIMRC}_backup"
fi

gh repo clone "DanThomas64/nvim.init" $VIMRC

# Install hack Font
declare -a fonts=(
	Hack
)

version='2.2.2'
fonts_dir="${HOME}/.local/share/fonts"

if fc-match "Hack Nerd Font Mono" &>/dev/null; then
    echo "Hack Nerd Font Mono is already installed."
else
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
if

# Install oh-my-zsh and set zsh as default
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

sudo chsh -s /usr/bin/zsh $USERNAME
