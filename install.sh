#!/usr/bin/env bash

NVIM_CONFIG_FILE_DIR=~/.config/nvim
TMUX_CONFIG_FILE_PATH=~/.tmux.conf
ALACRITTY_CONFIG_FILE_PATH=~/.config/alacritty/alacritty.yml
ZSH_CONFIG_FILE_PATH=~/.zshrc
TERMINFO_DIR=~/.terminfo

function fix_tmux_alacritty_zsh_color_and_text_duplicate_issue() {
  curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz
  wait
  $(which tic) -xe tmux-256color,xterm-256color terminfo.src
  wait 
  rm terminfo.src
  wait
}

fix_tmux_alacritty_zsh_color_and_text_duplicate_issue

# https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#i-have-enabled-a-completion-plugin-but-the-completion-doesnt-work
rm "$ZSH_COMPDUMP"

# Checking if brew installed then installing ripgrep
if [ -x "$(command -v brew)" ]; then
  brew install ripgrep
  wait
else
  echo "brew is not installed. Skip installing ripgrep..."
fi

function link_zsh_config() {
  ln -s ~/.dotfiles/zsh/.zshrc $ZSH_CONFIG_FILE_PATH
}

function link_nvim_config() {
  ln -s ~/.dotfiles/nvim/lua/custom "$NVIM_CONFIG_FILE_DIR/lua/custom"
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

function clone_nvchad_editor() {
  git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1
}

# Checking if ZSH config already exists
if [ -f $ZSH_CONFIG_FILE_PATH ]; then
  printf "ZSH config already exists"
else
  printf "Creating and linking ZSH config file"
  link_zsh_config
  printf "Creating and linking ZSH config file completed 🥳"
fi

# Checking if Neovim config already exists
if [ -d $NVIM_CONFIG_FILE_DIR ]; then
  printf "Neovim config setup started...\n"
  link_nvim_config
  printf "Neovim config setup done \n\n"
else
  printf ".config folder not found. Creating .config folder on home directory\n\n"
  mkdir -p ~/.config/
  clone_nvchad_editor
  link_nvim_config
  printf ".config folder created and Neovim config setup done \n\n"
fi

# Checking if tmux config already exists
if [ -f $TMUX_CONFIG_FILE_PATH ]; then
  printf "Tmux config file already exists\n\n"
else
  printf "Setting up Tmux config\n"
  link_tmux_config
  clone_tmux_plugin_manager
  printf "Setting up Tmux config done\n\n"
fi

# Checking if alacritty config already exists
if [ -f $ALACRITTY_CONFIG_FILE_PATH ]; then
  printf "Alacritty config file already exists\n\n"
else
  printf "Setting up Alacritty config\n"
  link_alacritty_config
  printf "Setting up Alacritty config done\n\n"
fi
