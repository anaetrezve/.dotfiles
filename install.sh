#!/usr/bin/env bash

# cd ~/ ; ln -s ~/.dotfiles/zsh/.zshrc

NVIM_CONFIG_FILE_DIR=~/.config/

function link_nvim_config_file() {
#	ln -s ./nvim/init.lua ~/.config/nvim/init.lua
	ln -s ~/.dotfiles/nvim/ ~/.config/
}

if [ -d $NVIM_CONFIG_FILE_DIR ]; then
	echo "Linking nvim config folder..."
	link_nvim_config_file;
else 
	mkdir -p ~/.config/
	link_nvim_config_file;
fi

