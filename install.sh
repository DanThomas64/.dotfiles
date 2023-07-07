#!/bin/bash

DOTFILES="$HOME/.dotfiles"
URL="https://github.com/DanThomas64/.dotfiles/"

dotfiles() {
	git --git-dir="$HOME/.dotfiles" --work-tree="$HOME" "$@"
}

git clone -b linux --bare $URL $DOTFILES
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout || echo -e 'Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ndtf checkout'

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

declare -a apps=(
	nvim
	fzf
	treesitter
	zsh
	ohmyzsh
	exa
	bat
)

for app in "${apps[@]}"; do
	apt install -y ${app[@]}
done

sudo chsh -s /usr/bin/zsh $USERNAME
