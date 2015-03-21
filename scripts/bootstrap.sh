#!/bin/bash

set -f # disable globbing to pass '*' into find command later

THIS_SCRIPT=$(readlink -f $0)
SCRIPT_DIR=$(dirname ${THIS_SCRIPT})
DOTFILES_ROOT=$(dirname ${SCRIPT_DIR})

exclude_paths=( .git scripts )

# create query for adding paths to exclude from linking
exclude_query="-not -path ${DOTFILES_ROOT}" # remove dotfiles directory, but not files
for path in ${exclude_paths[*]}
do
    exclude_query="${exclude_query} -not -path ${DOTFILES_ROOT}/${path} -not -path ${DOTFILES_ROOT}/${path}/*  "
done

find ${DOTFILES_ROOT} ${exclude_query} -type f
