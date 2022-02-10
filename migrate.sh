#!/bin/bash

default=".vimrc .vim .bashrc .gitconfig"

if [ $# -gt 0 ]; then
    files="${@:-$default}"
fi

OLDDIR="$HOME/.dotfiles/old/"

if [ ! -d $OLDDIR ]; then
    mkdir $OLDDIR
fi

for filename in $files; do

    $file = "$HOME/.dotfiles/$filename"
    $link = "$HOME/$filename"

    echo "Migrating $file"

    if [[ -L $link && $file -ef $link ]]; then
        echo "$link already points to $file"
        continue
    fi

    if [[ -f $link ]]; then

        mv $link $OLDDIR
        echo "$link moved to $OLDDIR"

    fi

    ln -s $file $link
    echo "Link to $file created"

done
