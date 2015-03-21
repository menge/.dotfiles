#!/bin/bash

set -f # disable globbing to pass '*' into find command later

THIS_SCRIPT=$(readlink -f $0)
SCRIPT_DIR=$(dirname ${THIS_SCRIPT})
DOTFILES_ROOT=$(dirname ${SCRIPT_DIR})

exclude_paths=( .git scripts )

# create query for adding paths to exclude from linking
exclude_query="-not -path ." # remove dotfiles directory, but not files
for path in ${exclude_paths[*]}
do
    exclude_query="${exclude_query} -not -path ./${path} -not -path ./${path}/*  "
done

echo "================================================================================"
echo "Creating Directories"
echo "================================================================================"
dirs=$( (cd ${DOTFILES_ROOT} ; find . ${exclude_query} -type d -printf "%P\n" | sort) )
for dir in ${dirs}
do
    if [ -d "${HOME}/${dir}" ]
    then
        echo "${HOME}/${dir}"
    else
        echo "${HOME}/${dir}: Making missing directory"
        mkdir -p ${HOME}/${dir}
    fi
done

echo "================================================================================"
echo "Linking Dotfiles"
echo "================================================================================"
dotfiles=$( (cd ${DOTFILES_ROOT} ; find . ${exclude_query} -type f -printf "%P\n" | sort) )
for dotfile in ${dotfiles}
do
    #(cd ${DOTFILES_ROOT} ; ln -s ${dotfile} $HOME

    linkfile=$(readlink -f ${HOME}/${dotfile})
    if [ -e ${linkfile} ]
    then
        realfile=$(cd ${DOTFILES_ROOT}; readlink -f ${dotfile})
        if [ ${linkfile} == ${realfile} ]
        then
            echo "${dotfile}"
        else
            echo "Creating link for ${dotfile}"
            rm -f ${HOME}/${dotfile}
            (cd ${DOTFILES_ROOT}; ln -s $(readlink -f ${dotfile}) ${linkfile})
        fi
    else
        echo "Creating link for ${dotfile}"
        (cd ${DOTFILES_ROOT}; ln -s $(readlink -f ${dotfile}) ${linkfile})
    fi
done
