#!/bin/bash

DOTFILES="$HOME/.dotfiles"
URL="https://github.com/DanThomas64/.dotfiles/"

declare -a apps=(
	neovim
	fzf
	treesitter
	zsh
	exa
	bat
	stow
)

for app in "${apps[@]}"; do
	yay -S ${app[@]} --noconfirm
done

git clone $URL $DOTFILES

cd $DOTFILES

stow . --adopt

git restore .

cd $HOME

# Also should be used to install ZSH and OH-MY-ZSH exa neovim
# nodejs, perl, rust,

declare -a fonts=(
	Hack
)

version='2.2.2'
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
fc-match "Hack Nerd Font Mono" -a

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

sudo chsh -s /usr/bin/zsh $USERNAME
