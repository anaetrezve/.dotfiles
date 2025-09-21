# .dotfiles

> A comprehensive macOS development environment configuration with automated setup and cleanup scripts.

## 🚀 Quick Start

```bash
# Clone to home directory
git clone https://github.com/anaetrezve/.dotfiles.git ~/.dotfiles

# Setup everything
~/.dotfiles/setup.sh --all
```

## 📋 What's Included

### 🛠️ Development Tools

- **[Neovim](https://neovim.io/)** - Modern Vim-based editor with LSP support
- **[tmux](https://github.com/tmux/tmux)** - Terminal multiplexer with custom themes
- **[mise](https://mise.jdx.dev/)** - Runtime version manager for multiple languages
- **[Starship](https://starship.rs/)** - Fast, customizable cross-shell prompt

### 🖥️ Terminal Emulators

- **[WezTerm](https://wezfurlong.org/wezterm/)** - GPU-accelerated terminal with Lua configuration
- **[Ghostty](https://ghostty.org/)** - Fast, native terminal emulator
- **[Kitty](https://sw.kovidgoyal.net/kitty/)** - Fast, feature-rich terminal

### 🐚 Shell Environment

- **zsh** configuration with plugins:
  - Syntax highlighting
  - Auto-suggestions
  - History substring search
  - Command recommendations

### 📦 System Utilities

- **[Homebrew](https://brew.sh/)** - Package manager for macOS
- **[zoxide](https://github.com/ajeetdsouza/zoxide)** - Smart directory jumper
- **[ripgrep](https://github.com/BurntSushi/ripgrep)** - Fast text search
- **[fd](https://github.com/sharkdp/fd)** - Fast `find` alternative
- **[fzf](https://github.com/junegunn/fzf)** - Fuzzy finder
- **[eza](https://github.com/eza-community/eza)** - Modern `ls` replacement

## 📁 Repository Structure

```
.dotfiles/
├── 📜 AGENTS.md          # Automation scripts documentation
├── 🔧 setup.sh           # Environment setup script
├── 🧹 clean.sh           # Environment cleanup script
├── 📚 cheatsheets/       # Command reference guides
├── 🎨 eza/               # eza theming configuration
├── 👻 ghostty/           # Ghostty terminal config
├── 🐱 kitty/             # Kitty terminal config
├── ⚡ mise/              # Runtime version manager config
├── 💫 nvim/              # Neovim configuration
├── 🔧 opencode/          # VS Code integration
├── ⭐ starship/          # Shell prompt configuration
├── 🖥️  tmux/             # Terminal multiplexer config
├── 💻 wezterm/           # WezTerm configuration
└── 🐚 zsh/               # Shell environment setup
```

## ⚙️ Installation Options

### Full Installation (Recommended)

```bash
./setup.sh --all
```

### Selective Installation

```bash
# Install only Neovim and tmux configurations
./setup.sh --setup-neovim --setup-tmux

# Setup shell environment
./setup.sh --setup-zsh --install-zsh-plugins

# Install system packages only
./setup.sh --install-packages

# Setup all configs without installing apps
./setup.sh --all-configs
```

### Available Options

| Command              | Description                    |
| -------------------- | ------------------------------ |
| `--all`              | Install everything             |
| `--homebrew`         | Setup Homebrew package manager |
| `--install-packages` | Install essential CLI tools    |
| `--setup-neovim`     | Configure Neovim editor        |
| `--setup-tmux`       | Configure tmux multiplexer     |
| `--setup-zsh`        | Setup shell configuration      |
| `--setup-starship`   | Configure shell prompt         |
| `--all-configs`      | Setup all config files         |

> Run `./setup.sh --help` for complete options list

## 🧹 Cleanup

Remove configurations and applications:

```bash
# Remove everything (⚠️ destructive)
./clean.sh --all

# Remove only configuration files
./clean.sh --configs-only

# Remove specific tool configs
./clean.sh --neovim-configs-only --tmux-configs-only
```

> **Warning**: Cleanup operations are destructive. Backup important configurations first.

## 🔧 Key Features

### Neovim Configuration

- LSP support for multiple languages (Go, Python, TypeScript, Rust, Ruby, Lua, YAML)
- Plugin management with [lazy.nvim](https://github.com/folke/lazy.nvim)
- Modern completion with [blink.cmp](https://github.com/Saghen/blink.cmp)
- Git integration, file explorer, and fuzzy finding
- Custom themes and statusline

### tmux Setup

- Custom key bindings (prefix: `Ctrl+g`)
- Plugin management with TPM
- Theme integration (Catppuccin variants)
- Session persistence and restoration

### Shell Environment

- Optimized zsh configuration with XDG Base Directory compliance
- Smart PATH management for various development tools
- Custom aliases and functions for productivity
- Homebrew integration with automatic path detection

## 📋 Prerequisites

- macOS (primary target)
- Terminal access
- Internet connection for package downloads
- Admin privileges for some installations

## 📖 Documentation

- **[AGENTS.md](AGENTS.md)** - Detailed documentation for setup and cleanup scripts
- **[Cheatsheets](cheatsheets/)** - Command reference guides for installed tools

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## ⚠️ Important Notes

- Scripts are designed to be idempotent (safe to run multiple times)
- Some operations may require `sudo` privileges
- Always backup existing configurations before running cleanup scripts
- Review changes in git before committing customizations

## 📄 License

This project is licensed under the MIT License - see the repository for details.

---

> 💡 **Tip**: Start with `./setup.sh --help` to explore available options
