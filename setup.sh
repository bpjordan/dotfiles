#!/bin/bash

#Install all dependecies

sudo apt install curl wget vim zsh -y
if [[ $? -ne 0 ]]; then echo "Required dependencies failed to install, aborting" && return 1; fi

sudo apt install neofetch -y


#Install Oh My Zsh and plugins

if [[ ! -d $HOME/.oh-my-zsh ]]; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

    ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

    ln -s $HOME/.dotfiles/bjordan.zsh-theme $ZSH_CUSTOM/themes

else
    echo "Oh-my-zsh directory already exists"
fi


#Migrate configuration files

$HOME/.dotfiles/migrate.sh

