# dotfiles
Personal Dotfiles

Setup environment in a new computer
Make sure to have git installed, then:
## Clone your github repository
`git clone --bare https://github.com/USERNAME/dotfiles.git $HOME/.dotfiles`
## Define the alias in the current shell scope
`alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'`
## Checkout the actual content from the git repository to your `$HOME`
`dotfiles checkout`
