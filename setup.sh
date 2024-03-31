#!/usr/bin/env bash

function setup_zshenv() {
  echo "Coping .zshenv to home directory \n"
  cp -R $HOME/.dotfiles/.zshenv $HOME
  source ~/.zshenv
}

function install_zsh_plugins() {
  # powerlevel10k
  brew install powerlevel10k
  # zsh-syntax-highlighting
  brew install zsh-syntax-highlighting
  # zsh-autosuggestions
  brew install zsh-autosuggestions
  # zsh-history-substring-search
  brew install zsh-history-substring-search
  # zsh-you-should-use
  brew install zsh-you-should-use
}

function install_other_necessary_packages() {
  brew install tree    # allows you to see the outline of a directory
  brew install zoxide  # jump anywhere within your filesystem with z <foldername>
  brew install ripgrep # blazingly fast grep
  brew install fd      # blazingly fast find
  brew install eza
  brew install neovim
  brew install tmux
  brew install --cask visual-studio-code
  brew install --cask kitty
  brew install --cask raycast

  # programming languages & tools
  brew install go
  brew install rust
  brew install nvm
  brew install --cask mongodb-compass
  brew install --cask postman
  brew install docker

  # Nerd fonts
  brew tap homebrew/cask-fonts
  brew install --cask font-jetbrains-mono-nerd-font
}

function setup_alacritty_config() {
  if [[ $(command -v alacritty) == "" ]]; then
    echo "Alacritty not installed. Installing Alacritty"
    brew install --cask alacritty
  fi

  echo "Coping alacritty config"
  cp -R $HOME/.dotfiles/alacritty $XDG_CONFIG_HOME
}

function setup_kitty_config() {
  if [[ $(command -v kitty) == "" ]]; then
    echo "Kitty not installed. Installing Kitty"
    brew install --cask kitty
  fi

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
  if [[ $(command -v brew) == "" ]]; then
    echo "Tmux not installed. Installing Tmux"
    brew install tmux

    echo "Installing tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm
  fi

  echo "Coping tmux config"
  cp -R $HOME/.dotfiles/tmux $XDG_CONFIG_HOME
}

function setup_nvim_config() {
  if [[ $(command -v nvim) == "" ]]; then
    echo "Neovim not installed. Installing Neovim"
    brew install neovim
  fi

  # Temporary NVCHAD
  git clone https://github.com/NvChad/starter $XDG_CONFIG_HOME/nvim
  echo "Coping nvim config"
  cp -R $HOME/.dotfiles/nvim $XDG_CONFIG_HOME
}

function setup_zsh_config() {
  echo "Coping zsh config"
  cp -R $HOME/.dotfiles/zsh $XDG_CONFIG_HOME
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
setup_zsh_config
# setup_alacritty_config
setup_kitty_config
setup_tmux_config
setup_nvim_config
