#!/usr/bin/env bash

function install_or_update_brew_app() {
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

function install_or_update_brew_app() {
  local app_name="$1"
  # Check if the application is already installed
  if ! command -v "$app_name" &>/dev/null; then
    # If not installed, install using Homebrew
    echo "$app_name is not installed. Installing via Homebrew..."
    brew install "$app_name"

    # Check if installation was successful
    if [ $? -eq 0 ]; then
      echo "Installation of $app_name successful."
    else
      echo "Installation of $app_name failed. Please check Homebrew or try again later."
    fi
  else
    echo "$app_name is already installed."
  fi
}

function setup_zshenv() {
  echo "Setting up .zshenv to home directory \n"

  ln -nsf $HOME/.dotfiles/.zshenv $HOME
  source $HOME/.zshenv

  touch $XDG_CACHE_HOME/zsh/.zsh_history
  rm -f $HOME/.zsh_history
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
  install_or_update_brew_app zoxide
  install_or_update_brew_app ripgrep
  install_or_update_brew_app fd
  install_or_update_brew_app eza
  install_or_update_brew_app neovim
  install_or_update_brew_app tmux
  install_or_update_brew_app wezterm 
  install_or_update_brew_app starship

  # programming languages & tools
  # install_or_update_brew_app go
  # install_or_update_brew_app rust
  install_or_update_brew_app nvm

  # install_or_update_brew_app postman
  # install_or_update_brew_app docker
  # install_or_update_brew_app docker-compose
  # install_or_update_brew_app visual-studio-code

  # Nerd fonts
  install_or_update_brew_app font-jetbrains-mono-nerd-font
}

function setup_alacritty_config() {
  echo "Setting up alacritty config"
  ln -nsf $HOME/.dotfiles/alacritty $XDG_CONFIG_HOME
}

function setup_kitty_config() {
  echo "Setting up kitty config"
  ln -nsf $HOME/.dotfiles/kitty $XDG_CONFIG_HOME
}

function setup_homebrew() {
  eval "$(/opt/homebrew/bin/brew shellenv)"

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
  echo "Setting up tmux config"
  ln -nsf $HOME/.dotfiles/tmux $XDG_CONFIG_HOME

  echo "Installing tmux plugin manager"
  git clone https://github.com/tmux-plugins/tpm.git $XDG_CONFIG_HOME/tmux/plugins/tpm
}

# function setup_nvim_config() {
#   # Temporary NVCHAD
#   git clone https://github.com/NvChad/starter $XDG_CONFIG_HOME/nvim
#
#   echo "Setting up nvim config"
#   ln -nsf $HOME/.dotfiles/nvim/lua/custom $XDG_CONFIG_HOME/nvim/lua/custom
# }

function setup_nvim_config() {
  echo "Setting up nvim config"
  ln -nsf $HOME/.dotfiles/nvim $XDG_CONFIG_HOME
}

function setup_zsh_config() {
  echo "Setting up zsh config"
  ln -nsf $HOME/.dotfiles/zsh $XDG_CONFIG_HOME
}

function setup_wezterm_config() {
  echo "Setting up wezterm config"
  ln -nsf $HOME/.dotfiles/wezterm $XDG_CONFIG_HOME
}

function setup_starship_config() {
  echo "Setting up starship config"
  ln -nsf $HOME/.dotfiles/starship $XDG_CONFIG_HOME
}

# if [ "$(uname)" == "Darwin" ]; then
# Do something under Mac OS X platform
# setup_homebrew
# elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
# fi

function setup_mac_key_repeat() {
  if [ "$(uname)" == "Darwin" ]; then
    defaults write -g ApplePressAndHoldEnabled -bool false
    defaults write -g InitialKeyRepeat -int 13
    defaults write -g KeyRepeat -int 1
  fi
}


function show_help() {
  GREEN="\033[1;32m"
  YELLOW="\033[1;33m"
  BOLD="\033[1m"
  RESET="\033[0m"
  CYAN="\033[1;36m"

  echo 
  echo -e "${CYAN}${BOLD}Usage:${RESET} ${GREEN}$0 [OPTION]${RESET}"
  echo 
  echo -e "${CYAN}${BOLD}Options:${RESET}"
  
  echo -e "  ${GREEN}-h, --help${RESET}                    ${YELLOW}Display this help message and exit.${RESET}"
  echo -e "  ${GREEN}-hb, --homebrew${RESET}               ${YELLOW}Install and configure Homebrew package manager.${RESET}"
  echo -e "  ${GREEN}-sz, --setup-zshenv${RESET}           ${YELLOW}Set up the .zshenv file for shell configuration.${RESET}"
  echo -e "  ${GREEN}-izp, --install-zsh-plugins${RESET}   ${YELLOW}Install useful plugins for zsh (Z shell).${RESET}"
  echo -e "  ${GREEN}-in, --install-packages${RESET}       ${YELLOW}Install essential system packages.${RESET}"
  echo -e "  ${GREEN}-sa, --setup-alacritty${RESET}        ${YELLOW}Configure Alacritty terminal settings.${RESET}"
  echo -e "  ${GREEN}-sk, --setup-kitty${RESET}            ${YELLOW}Set up Kitty terminal emulator configuration.${RESET}"
  echo -e "  ${GREEN}-st, --setup-tmux${RESET}             ${YELLOW}Configure tmux (terminal multiplexer) settings.${RESET}"
  echo -e "  ${GREEN}-sn, --setup-neovim${RESET}           ${YELLOW}Set up Neovim editor configuration.${RESET}"
  echo -e "  ${GREEN}-ss, --setup-starship${RESET}         ${YELLOW}Configure Starship prompt for shell customization.${RESET}"
  echo -e "  ${GREEN}-szc, --setup-zsh${RESET}             ${YELLOW}Set up the zsh shell configuration.${RESET}"
  echo -e "  ${GREEN}-sw, --setup-wezterm${RESET}          ${YELLOW}Configure WezTerm terminal settings.${RESET}"
  echo -e "  ${GREEN}-smkr, --setup-mac-keyrepeat${RESET}  ${YELLOW}Adjust macOS keyboard repeat and key press speed.${RESET}"
  echo -e "  ${GREEN}-a, --all${RESET}                     ${YELLOW}Run all setup steps and install necessary components.${RESET}"
  echo 
}



function initial_setup() {
  # Initial setup directories
  mkdir -p $HOME/.config
  mkdir -p $XDG_CACHE_HOME/zsh

  # Parse command-line arguments
  if [[ $# -eq 0 ]]; then
    show_help
    exit 1
  fi

  while [[ $# -gt 0 ]]; do
    case $1 in
    -h | --help)
      show_help
      exit 0
      ;;
    -hb | --homebrew)
      setup_homebrew
      ;;
    -sz | --setup-zshenv)
      setup_zshenv
      ;;
    -izp | --install-zsh-plugins)
      install_zsh_plugins
      ;;
    -in | --install-packages)
      install_other_necessary_packages
      ;;
    -sa | --setup-alacritty)
      setup_alacritty_config
      ;;
    -sk | --setup-kitty)
      setup_kitty_config
      ;;
    -st | --setup-tmux)
      setup_tmux_config
      ;;
    -sn | --setup-neovim)
      setup_nvim_config
      ;;
    -szc | --setup-zsh)
      setup_zsh_config
      ;;
    -sw | --setup-wezterm)
      setup_wezterm_config
      ;;
    -ss | --setup-starship)
      setup_starship_config
      ;;
    -smkr | --setup-mac-keyrepeat)
      setup_mac_key_repeat
      ;;
    -a | --all)
      set_mac_key_repeat
      setup_homebrew
      setup_zshenv
      install_zsh_plugins
      install_other_necessary_packages
      setup_alacritty_config
      setup_kitty_config
      setup_tmux_config
      setup_nvim_config
      setup_zsh_config
      setup_wezterm_config
      ;;
    *)
      echo "Unknown option: $1"
      show_help
      exit 1
      ;;
    esac
    shift
  done
}

# Initial setup
initial_setup "$@"

