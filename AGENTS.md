# Agents

This document describes the available agents (scripts) in this dotfiles repository for setting up and cleaning the development environment.

## setup.sh

A comprehensive setup script for configuring a macOS development environment with essential tools and configurations.

### Usage

```bash
./setup.sh [OPTION]
```

### Options

- `-h, --help`: Display help message and exit
- `-hb, --homebrew`: Install and configure Homebrew package manager
- `-sz, --setup-zshenv`: Set up the .zshenv file for shell configuration
- `-izp, --install-zsh-plugins`: Install useful plugins for zsh (Z shell)
- `-ip, --install-packages`: Install essential system packages
- `-st, --setup-tmux`: Configure tmux (terminal multiplexer) settings
- `-sn, --setup-neovim`: Set up Neovim editor configuration
- `-ss, --setup-starship`: Configure Starship prompt for shell customization
- `-szc, --setup-zsh`: Set up the zsh shell configuration
- `-sw, --setup-wezterm`: Configure WezTerm terminal settings
- `-sm, --setup-mise`: Setup mise config
- `-sg, --setup-ghostty`: Configure Ghostty terminal settings
- `-smkr, --setup-mac-keyrepeat`: Adjust macOS keyboard repeat and key press speed
- `-sk, --setup-kitty`: Setup kitty config
- `-ac, --all-configs`: Setup all configs
- `-a, --all`: Run all setup steps and install necessary components

### Examples

```bash
# Setup everything
./setup.sh --all

# Setup only Neovim and tmux
./setup.sh --setup-neovim --setup-tmux

# Install packages only
./setup.sh --install-packages
```

## clean.sh

A cleanup script for removing installed configurations and applications from the development environment.

### Usage

```bash
./clean.sh [OPTION]
```

### Options

- `-h, --help`: Show help message and exit
- `-a, --all`: Remove all configs, apps, and zsh plugins
- `-co, --configs-only`: Remove all configs
- `-ao, --apps-only`: Remove all apps
- `-zo, --zsh-plugins-only`: Remove all zsh plugins
- `-nco, --neovim-configs-only`: Remove only Neovim configs
- `-zco, --zsh-configs-only`: Remove only ZSH configs
- `-tco, --tmux-configs-only`: Remove only Tmux configs
- `-noco, --nodejs-configs-only`: Remove only Node.js configs
- `-wco, --wezterm-configs-only`: Remove only Wezterm configs
- `-oco, --other-configs-only`: Remove only Other configs
- `-gco, --ghostty-config-only`: Remove only Ghostty configs
- `-kco, --kitty-config-only`: Remove only Kitty configs
- `-mco, --mise-config-only`: Remove only Mise configs

### Examples

```bash
# Remove everything
./clean.sh --all

# Remove only configs
./clean.sh --configs-only

# Remove only Neovim configs
./clean.sh --neovim-configs-only
```

### Notes

- Always review the script output before running destructive operations
- Some operations may require administrative privileges
- Backup important data before running cleanup operations