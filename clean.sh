#!/usr/bin/env bash

function remove_all_configs() {
  echo "Removing files and folder from HOME directory"
  rm -rf ~/.tmux  ~/.zsh* ~/.zprofile ~/.nvm ~/.npm ~/.viminfo ~/.terminfo

  echo "Removing files and folder from .config directory"
  rm -rf ~/.config/zsh ~/.config/kitty ~/.config/tmux ~/.config/nvim ~/.config/alacritty

  echo "Removing files and folder from .cache directory"
  rm -rf ~/.cache/nvim

  echo "Removing files and folder from .local directory"
  rm -rf ~/.local/share/nvim ~/.local/state/nvim
}

function remove_all_apps() {
  echo "Removing applications using brew"
  brew remove neovim
  brew remove tmux
  brew remove nvm
  brew remove zoxide
  brew remove ripgrep
  brew remove fd
  brew remove eza
  brew remove go
  brew remove rust
  # brew remove docker
  # brew remove kitty
  # brew remove alacritty
  # brew remove visual-studio-code
  # brew remove mongodb-compass
  # brew remove postman
}

function remove_all_zsh_plugins() {
  echo "Removing zsh plugins"
  brew remove zsh-syntax-highlighting
  brew remove zsh-autosuggestions
  brew remove zsh-history-substring-search
  brew remove zsh-you-should-use
}

# Calling all functions here
remove_all_configs
remove_all_apps
remove_all_zsh_plugins

brew cleanup
