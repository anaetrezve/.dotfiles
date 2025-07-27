#!/usr/bin/env bash

function remove_neovim_configs {
  echo "Removing Neovim configs"
  rm -rf ~/.config/nvim ~/.cache/nvim ~/.local/share/nvim ~/.local/state/nvim
}

function remove_zsh_configs() {
  echo "Removing ZSH configs"
  rm -rf ~/.zsh* ~/.zprofile ~/.config/zsh
}

function remove_tmux_configs() {
  echo "Removing Tmux configs"
  rm -rf ~/.tmux ~/.config/tmux
}

function remove_nodejs_configs() {
  echo "Removing Node.js related configs"
  rm -rf ~/.nvm ~/.npm ~/.yarn ~/.config/nvm
}

function remove_wezterm_configs() {
  echo "Removing Wezterm configs"
  rm -rf ~/.config/wezterm
}

function remove_other_configs() {
  echo "Removing Other configs"
  rm -rf ~/.terminfo
}

function remove_ghostty_configs() {
  echo "Removing Ghostty configs"
  rm -rf ~/.config/ghostty
}

function remove_kitty_configs() {
  echo "Removing Kitty configs"
  rm -rf ~/.config/kitty
}

function remove_mise_configs() {
  echo "Removing Mise configs"
  rm -rf ~/.config/mise
}

function remove_all_configs() {
  remove_zsh_configs
  remove_tmux_configs
  remove_nodejs_configs
  remove_wezterm_configs
  remove_neovim_configs
  remove_other_configs
  remove_ghostty_configs
  remove_kitty_configs
  remove_mise_configs
}

function remove_all_apps() {
  echo "Removing applications using brew"
  brew remove neovim
  brew remove tmux
  # brew remove nvm
  brew remove zoxide
  brew remove ripgrep
  brew remove fd
  brew remove eza
  brew remove go
  brew remove rust
  brew remove docker
  # brew remove visual-studio-code
  brew remove mongodb-compass
  brew remove postman
}

function remove_all_zsh_plugins() {
  echo "Removing zsh plugins"
  brew remove zsh-syntax-highlighting
  brew remove zsh-autosuggestions
  brew remove zsh-history-substring-search
  brew remove zsh-you-should-use
}

function show_help {
  echo "Usage: $0 [OPTION]"
  echo "Options:"
  echo "  -a, --all                      Remove all configs, apps, and zsh plugins"
  echo "  -co, --configs-only            Remove all configs"
  echo "  -ao, --apps-only               Remove all apps"
  echo "  -zo, --zsh-plugins-only        Remove all zsh plugins"
  echo "  -nco, --neovim-configs-only    Remove only Neovim configs"
  echo "  -zco, --zsh-configs-only       Remove only ZSH configs"
  echo "  -tco, --tmux-configs-only      Remove only Tmux configs"
  echo "  -noco, --nodejs-configs-only   Remove only Node.js configs"
  echo "  -wco, --wezterm-configs-only   Remove only Wezterm configs"
  echo "  -oco, --other-configs-only     Remove only Other configs"
  echo "  -gco, --ghostty-configs-only   Remove only Ghostty configs"
  echo "  -kco, --kitty-configs-only     Remove only Kitty configs"
  echo "  -mco, --mise-configs-only      Remove only Mise configs"
  echo "  -h, --help                     Show this help message and exit"
}

# Parse command-line arguments
if [[ $# -eq 0 ]]; then
  show_help
  exit 1
fi

while [[ $# -gt 0 ]]; do
  case $1 in
  -a | --all)
    remove_all_configs
    remove_all_apps
    remove_all_zsh_plugins
    brew cleanup
    ;;
  -co | --configs-only)
    remove_all_configs
    ;;
  -ao | --apps-only)
    remove_all_apps
    brew cleanup
    ;;
  -zo | --zsh-plugins-only)
    remove_all_zsh_plugins
    ;;
  -nco | --neovim-configs-only)
    remove_neovim_configs
    ;;
  -zco | --zsh-configs-only)
    remove_zsh_configs
    ;;
  -tco | --tmux-configs-only)
    remove_tmux_configs
    ;;
  -noco | --nodejs-configs-only)
    remove_nodejs_configs
    ;;
  -wco | --wezterm-configs-only)
    remove_wezterm_configs
    ;;
  -oco | --other-configs-only)
    remove_other_configs
    ;;
  -gco | --ghostty-config-only)
    remove_ghostty_configs
    ;;
  -kco | --kitty-config-only)
    remove_kitty_configs
    ;;
  -mco | --mise-config-only)
    remove_mise_configs
    ;;
  -h | --help)
    show_help
    exit 0
    ;;
  *)
    echo "Unknown option: $1"
    show_help
    exit 1
    ;;
  esac
  shift
done
