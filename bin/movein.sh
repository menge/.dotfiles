#!/bin/bash

BARE_GIT_REPO_DIR="$HOME/.dotfiles"
REPO_LOCATION="ssh://git@github.com/menge/.dotfiles"

if [ -d $BARE_GIT_REPO_DIR ] ; then
    echo "Git directory already exists... Exiting."
    exit 1
fi

git clone --bare $REPO_LOCATION $BARE_GIT_REPO_DIR

mkdir -p .config-backup
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
