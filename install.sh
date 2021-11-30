#!/usr/bin/env bash

# cd ~/ ; ln -s ~/.dotfiles/zsh/.zshrc

NVIM_CONFIG_FILE_DIR=~/.config/nvim

function link_nvim_config_file() {
	ln -s ./nvim/init.vim ~/.config/nvim/init.vim
}

if [ -d $NVIM_CONFIG_FILE_DIR ]; then
	echo "Linking nvim config file..."
	link_nvim_config_file;
else 
	mkdir -p ~/.config/nvim
	link_nvim_config_file;
fi

