#!/bin/bash

#Install all dependecies

sudo apt install curl wget vim zsh -y
if [[ $? -ne 0 ]]; then echo "Required dependencies failed to install, aborting" && return 1; fi

#Migrate configuration files

$HOME/.dotfiles/migrate.sh

