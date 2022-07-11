# dotfiles
Personal Dotfiles

## Setup as per
https://fwuensche.medium.com/how-to-manage-your-dotfiles-with-git-f7aeed8adf8b

https://dev.to/bowmanjd/store-home-directory-config-files-dotfiles-in-git-using-bash-zsh-or-powershell-the-bare-repo-approach-35l3

## Adding new dotfiles
`dotfiles status`
`dotfiles add .vimrc`
`dotfiles commit -m "Add vimrc"`

Setup environment in a new computer
Make sure to have git installed, then:
## Clone your github repository
`git clone --bare https://github.com/USERNAME/dotfiles.git $HOME/.dotfiles`
## Define the alias in the current shell scope
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
## Checkout the actual content from the git repository to your `$HOME`
`dotfiles checkout`
