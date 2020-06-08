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
    files=$(git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout 2>&1 | egrep "^\s+" | awk {'print $1'})
    for file in $files
    do
        dname=$(dirname $file)
        echo "backing up: $file"
        if [ "$dname" = "." ] ; then
            mv $file .config-backup/$file
        else
            mkdir -p .config-backup/$dname
            mv $file .config-backup/$file
        fi
    done
fi;
git --git-dir=$HOME/.dotfiles --work-tree=$HOME checkout
git --git-dir=$HOME/.dotfiles --work-tree=$HOME config status.showUntrackedFiles no
