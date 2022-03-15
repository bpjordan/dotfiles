#!/bin/bash

#Install all dependecies

sudo apt install neofetch zsh -y

#Migrate configuration files

$HOME/.dotfiles/migrate.sh

#Install Oh My Zsh and plugins

if [[ ! -d $HOME/.oh-my-zsh ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

    ln -s $HOME/.dotfiles/bjordan.zsh-theme $ZSH_CUSTOM/themes

else
    echo "Oh-my-zsh directory already exists"
fi


