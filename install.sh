#!/usr/bin/env bash

NVIM_CONFIG_FILE_DIR=~/.config
TMUX_CONFIG_FILE_PATH=~/.tmux.conf
ALACRITTY_CONFIG_FILE_PATH=~/.config/alacritty/alacritty.yml

function link_nvim_config() {
	ln -s ~/.dotfiles/nvim ~/.config
}

function link_tmux_config() {
  ln -s ~/.dotfiles/tmux/.tmux.conf $TMUX_CONFIG_FILE_PATH
}

function link_alacritty_config() {
	ln -s ~/.dotfiles/alacritty ~/.config
}

function clone_tmux_plugin_manager() {
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# Checking if Neovim config already exists
if [ -d $NVIM_CONFIG_FILE_DIR ]; then
	printf "Neovim config setup started...\n";
	link_nvim_config;
	printf "Neovim config setup done \n\n";
else 
	printf ".config folder not found. Creating .config folder on home directory\n\n";
	mkdir -p ~/.config/
	link_nvim_config;
  printf ".config folder created and Neovim config setup done \n\n";
fi

# Checking if tmux config already exists
if [ -f $TMUX_CONFIG_FILE_PATH ]; then
  printf "Tmux config file already exists\n\n";
else
  printf "Setting up Tmux config\n";
  link_tmux_config;
  clone_tmux_plugin_manager;
  printf "Setting up Tmux config done\n\n";
fi

# Checking if alacritty config already exists
if [ -f $ALACRITTY_CONFIG_FILE_PATH ]; then
  printf "Alacritty config file already exists\n\n";
else
  printf "Setting up Alacritty config\n";
  link_alacritty_config;
  printf "Setting up Alacritty config done\n\n";
fi

