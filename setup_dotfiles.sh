#!/bin/bash


set -e

echo "--- Setting up dotfiles ---"

echo "Cloning dotfiles repository to ~/.dotfiles"
git clone --bare git@github.com:pafsmith/dotfiles.git $HOME/.dotfiles

echo "Creating 'dotfiles' alias"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Checkout the files
echo "Checking out files from the dotfiles repository..."
dotfiles checkout

# Check for conflicts and handle them
if [ $? = 0 ]; then
    echo "Checked out dotfiles."
else
    echo "Backuping pre-existing dotfiles..."
    mkdir -p .dotfiles-backup
    dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
    dotfiles checkout
fi

echo "Dotfiles setup is complete."
