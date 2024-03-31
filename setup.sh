#!/usr/bin/env bash

install_or_update_brew_app() {
   local app_name="$1"

    # Check if the application is installed as a formula or cask
    if ! command -v "$app_name" &>/dev/null || brew list --formula "$app_name" &>/dev/null || brew list --cask "$app_name" &>/dev/null; then
        echo "$app_name is already installed."
    else
        # If not installed, check if it's a cask
        if brew info --cask "$app_name" &>/dev/null; then
            # If it's a cask, install it using Homebrew Cask
            echo "$app_name is not installed. Installing via Homebrew Cask..."
            brew install --cask "$app_name"
        else
            # If it's not a cask, install it using regular Homebrew
            echo "$app_name is not installed. Installing via Homebrew..."
            brew install "$app_name"
        fi

        # Check if installation was successful
        if [ $? -eq 0 ]; then
            echo "Installation of $app_name successful."
        else
            echo "Installation of $app_name failed. Please check Homebrew or try again later."
        fi
    fi
}

function setup_zshenv() {
  echo "Coping .zshenv to home directory \n"
  cp -R $HOME/.dotfiles/.zshenv $HOME
  source ~/.zshenv
}

function install_zsh_plugins() {
  # powerlevel10k
  install_or_update_brew_app powerlevel10k
  # zsh-syntax-highlighting
  install_or_update_brew_app zsh-syntax-highlighting
  # zsh-autosuggestions
  install_or_update_brew_app zsh-autosuggestions
  # zsh-history-substring-search
  install_or_update_brew_app zsh-history-substring-search
  # zsh-you-should-use
  install_or_update_brew_app zsh-you-should-use
}

function install_other_necessary_packages() {
  install_or_update_brew_app tree  
  install_or_update_brew_app zoxide 
  install_or_update_brew_app ripgrep
  install_or_update_brew_app fd     
  install_or_update_brew_app eza
  install_or_update_brew_app neovim
  install_or_update_brew_app tmux
  install_or_update_brew_app visual-studio-code
  install_or_update_brew_app kitty
  install_or_update_brew_app raycast
  # install_or_update_brew_app alacritty

  # programming languages & tools
  install_or_update_brew_app go
  install_or_update_brew_app rust
  install_or_update_brew_app mongodb-compass
  install_or_update_brew_app postman
  install_or_update_brew_app docker

  # Nerd fonts
  brew tap homebrew/cask-fonts
  install_or_update_brew_app font-jetbrains-mono-nerd-font
}

function setup_alacritty_config() {
  echo "Coping alacritty config"
  cp -R $HOME/.dotfiles/alacritty $XDG_CONFIG_HOME
}

function setup_kitty_config() {
  echo "Coping kitty config"
  cp -R $HOME/.dotfiles/kitty $XDG_CONFIG_HOME
}

function setup_homebrew() {
  if [[ $(command -v brew) == "" ]]; then
    echo "Hombrew not installed. Installing Hombrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    echo "Updating Homebrew"
    brew update
  fi
}

function setup_tmux_config() {
  echo "Installing tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm.git $XDG_CONFIG_HOME/tmux/plugins/tpm

  echo "Coping tmux config"
  cp -R $HOME/.dotfiles/tmux $XDG_CONFIG_HOME
}

function setup_nvim_config() {
  # Temporary NVCHAD
  git clone https://github.com/NvChad/starter $XDG_CONFIG_HOME/nvim
  echo "Coping nvim config"
  cp -R $HOME/.dotfiles/nvim $XDG_CONFIG_HOME
}

function setup_zsh_config() {
  echo "Coping zsh config"
  cp -R $HOME/.dotfiles/zsh $XDG_CONFIG_HOME
}

function setup_nvm() {
  if [[ $(command -v nvm) == "" ]]; then
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  fi
}

# if [ "$(uname)" == "Darwin" ]; then
# Do something under Mac OS X platform
  setup_homebrew
# elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
# fi

# setting up
setup_zshenv
install_other_necessary_packages
install_zsh_plugins
setup_nvm
setup_zsh_config
# setup_alacritty_config
setup_kitty_config
setup_tmux_config
setup_nvim_config

