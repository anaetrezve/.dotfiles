# Agents

This document describes the available automation scripts (agents) in this dotfiles repository for setting up and cleaning a macOS development environment.

## Table of Contents

- [setup.sh](#setupsh) - Environment setup script
- [clean.sh](#cleansh) - Environment cleanup script
- [Prerequisites](#prerequisites)
- [Safety Notes](#safety-notes)

## setup.sh

A comprehensive setup script for configuring a macOS development environment with essential tools, applications, and configurations.

### Description

This script automates the installation and configuration of:

- Package managers (Homebrew)
- Shell environments (zsh with plugins)
- Terminal emulators (WezTerm, Ghostty, Kitty)
- Development tools (Neovim, tmux, Starship prompt)
- Runtime managers (mise)
- System optimizations (keyboard repeat settings)

### Usage

```bash
./setup.sh [OPTION]...
```

> **Note**: Multiple options can be combined in a single command.

### Options

| Option  | Long Option             | Description                                          |
| ------- | ----------------------- | ---------------------------------------------------- |
| `-h`    | `--help`                | Display help message and exit                        |
| `-hb`   | `--homebrew`            | Install and configure Homebrew package manager       |
| `-sz`   | `--setup-zshenv`        | Set up the .zshenv file for shell configuration      |
| `-izp`  | `--install-zsh-plugins` | Install useful plugins for zsh (Z shell)             |
| `-ip`   | `--install-packages`    | Install essential system packages                    |
| `-st`   | `--setup-tmux`          | Configure tmux (terminal multiplexer) settings       |
| `-sn`   | `--setup-neovim`        | Set up Neovim editor configuration                   |
| `-ss`   | `--setup-starship`      | Configure Starship prompt for shell customization    |
| `-szc`  | `--setup-zsh`           | Set up the zsh shell configuration                   |
| `-sw`   | `--setup-wezterm`       | Configure WezTerm terminal settings                  |
| `-sm`   | `--setup-mise`          | Setup mise configuration                             |
| `-sg`   | `--setup-ghostty`       | Configure Ghostty terminal settings                  |
| `-smkr` | `--setup-mac-keyrepeat` | Adjust macOS keyboard repeat and key press speed     |
| `-sk`   | `--setup-kitty`         | Setup Kitty terminal configuration                   |
| `-soc`  | `--setup-opencode`      | Setup opencode configuration                         |
| `-ac`   | `--all-configs`         | Setup all configuration files                        |
| `-a`    | `--all`                 | Run all setup steps and install necessary components |

### Examples

```bash
# Setup everything (recommended for new installations)
./setup.sh --all

# Setup only specific tools
./setup.sh --setup-neovim --setup-tmux

# Install packages and configure shell
./setup.sh --install-packages --setup-zsh

# Setup all configs without installing packages
./setup.sh --all-configs

# Get help
./setup.sh --help
```

## clean.sh

A cleanup script for removing installed configurations, applications, and plugins from the development environment.

### Description

This script provides granular control for removing:

- Configuration files and directories
- Installed applications via Homebrew
- Shell plugins and customizations
- Specific tool configurations

**⚠️ Warning**: This script performs destructive operations. Always backup important data before running.

### Usage

```bash
./clean.sh [OPTION]...
```

> **Note**: Multiple options can be combined, but use caution with destructive combinations.

### Options

| Option  | Long Option              | Description                               |
| ------- | ------------------------ | ----------------------------------------- |
| `-h`    | `--help`                 | Show help message and exit                |
| `-a`    | `--all`                  | Remove all configs, apps, and zsh plugins |
| `-co`   | `--configs-only`         | Remove all configuration files            |
| `-ao`   | `--apps-only`            | Remove all installed applications         |
| `-zo`   | `--zsh-plugins-only`     | Remove all zsh plugins                    |
| `-nco`  | `--neovim-configs-only`  | Remove only Neovim configurations         |
| `-zco`  | `--zsh-configs-only`     | Remove only ZSH configurations            |
| `-tco`  | `--tmux-configs-only`    | Remove only Tmux configurations           |
| `-noco` | `--nodejs-configs-only`  | Remove only Node.js configurations        |
| `-wco`  | `--wezterm-configs-only` | Remove only WezTerm configurations        |
| `-oco`  | `--other-configs-only`   | Remove only miscellaneous configurations  |
| `-gco`  | `--ghostty-config-only`  | Remove only Ghostty configurations        |
| `-kco`  | `--kitty-config-only`    | Remove only Kitty configurations          |
| `-mco`  | `--mise-config-only`     | Remove only Mise configurations           |
| `-occo` | `--opencode-config-only` | Remove only Opencode configurations       |

### Examples

```bash
# Remove everything (use with extreme caution)
./clean.sh --all

# Remove only configuration files (preserve apps)
./clean.sh --configs-only

# Remove specific tool configurations
./clean.sh --neovim-configs-only

# Remove multiple specific configs
./clean.sh --tmux-configs-only --zsh-configs-only

# Get help
./clean.sh --help
```

## Prerequisites

Before running these scripts, ensure you have:

1. **macOS**: These scripts are designed specifically for macOS
2. **Terminal Access**: Run from Terminal.app, iTerm2, or similar
3. **Internet Connection**: Required for downloading packages and tools
4. **Admin Privileges**: Some operations may require `sudo` access
5. **Backup**: Important data should be backed up before cleanup operations

## Safety Notes

### For setup.sh

- ✅ Generally safe to run multiple times (idempotent operations)
- ✅ Will skip already installed packages
- ⚠️ May overwrite existing configuration files
- 💡 Review configuration changes before committing

### For clean.sh

- ⚠️ **DESTRUCTIVE**: Permanently removes files and configurations
- ⚠️ Cannot be easily undone
- 🛡️ Always backup important configurations first
- 🔍 Review script output before confirming operations
- 💡 Test with specific options before using `--all`

### Best Practices

1. **Read Before Running**: Understand what each option does
2. **Start Small**: Use specific options before broad ones
3. **Backup First**: Create backups of important configurations
4. **Test Environment**: Consider testing in a virtual machine first
5. **Review Changes**: Check what files will be modified/removed
6. **Version Control**: Keep your dotfiles in version control

### Troubleshooting

- **Permission Errors**: Some operations may require `sudo` privileges
- **Network Issues**: Ensure stable internet connection for downloads
- **Homebrew Issues**: Run `brew doctor` to diagnose package manager problems
- **Path Issues**: Ensure `/usr/local/bin` and `/opt/homebrew/bin` are in your `$PATH`

### Support

For issues or questions:

1. Check the script output for error messages
2. Review the individual configuration files in this repository
3. Consult the documentation for specific tools being configured
