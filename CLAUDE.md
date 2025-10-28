# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a comprehensive macOS dotfiles repository that manages development environment configurations through automated setup and cleanup scripts. The repository uses symlinks to connect configuration files to their standard locations, and supports XDG Base Directory specification.

## Core Commands

### Setup Operations

```bash
# Full installation (recommended for new setups)
./setup.sh --all

# Setup only configuration files (no package installation)
./setup.sh --all-configs

# Setup specific tools
./setup.sh --setup-neovim --setup-tmux
./setup.sh --setup-zsh --install-zsh-plugins
./setup.sh --homebrew --install-packages
./setup.sh --setup-mise --setup-ghostty --setup-opencode
```

### Cleanup Operations

```bash
# Remove all configurations (destructive)
./clean.sh --all

# Remove only configuration files (preserve apps)
./clean.sh --configs-only

# Remove specific tool configurations
./clean.sh --neovim-configs-only
./clean.sh --tmux-configs-only --zsh-configs-only
```

### Testing Changes

When modifying setup or cleanup scripts:

1. Review the function being modified in `setup.sh` or `clean.sh`
2. Test with specific flags first before using `--all`
3. Check that symlinks are created correctly: `ls -la ~/.config/`
4. For shell changes, reload: `source ~/.zshenv && source ~/.config/zsh/.zshrc`
5. For tmux changes: `tmux source ~/.config/tmux/tmux.conf`
6. For Neovim changes: restart Neovim or `:source $MYVIMRC`

## Architecture and Key Concepts

### XDG Base Directory Compliance

All configurations follow XDG Base Directory specification:

- `XDG_CONFIG_HOME`: `~/.config` - configuration files
- `XDG_CACHE_HOME`: `~/.cache` - cache files
- `XDG_DATA_HOME`: `~/.local/share` - data files
- `XDG_STATE_HOME`: `~/.local/state` - state files (e.g., history)

Defined in `zsh/.zshenv` which is symlinked to `~/.zshenv` during setup.

### Symlink-Based Configuration

The setup process creates symlinks rather than copying files:

- Source: `~/.dotfiles/<tool>/`
- Target: `~/.config/<tool>/`
- Example: `~/.dotfiles/nvim` → `~/.config/nvim`

This allows version control of configurations while keeping them in standard locations.

### Shell Configuration Structure

**Load Order:**

1. `.zshenv` (sets XDG paths, sourced first)
2. `.zshrc` (in `$ZDOTDIR` = `~/.config/zsh/`)
   - `initializers.zsh` - environment setup
   - `aliases.zsh` - command aliases
   - `exports.zsh` - environment variables
   - `completion.zsh` - completion configuration
   - `loaders.zsh` - tool initializations (mise, zoxide, etc.)
   - Homebrew-installed plugins (powerlevel10k, autosuggestions, etc.)

**Local Overrides:**

- Create `zsh/local-config/config.zsh` for machine-specific settings
- Not tracked in git, safe for sensitive or machine-specific configurations

### Neovim Configuration

Structure:

```
nvim/
├── init.lua              # Entry point
└── lua/
    ├── config/          # Core configuration
    │   ├── options.lua  # Vim options
    │   ├── keymaps.lua  # Key bindings
    │   ├── lazy.lua     # Plugin manager setup
    │   ├── lsp.lua      # LSP configuration
    │   └── autocmd.lua  # Autocommands
    └── plugins/         # Plugin configurations
        ├── blink-cmp.lua
        ├── colorsheme.lua
        ├── conform.lua  # Formatting
        ├── linter.lua   # Linting
        └── ...
```

- Plugin manager: lazy.nvim
- LSP support for: Go, Python, TypeScript, Rust, Ruby, Lua, YAML
- Modern completion: blink.cmp
- Formatting: conform.nvim
- Linting: nvim-lint

### tmux Configuration

Key customizations in `tmux/tmux.conf`:

- **Prefix key**: `Ctrl+g` (not default `Ctrl+b`)
- **Split panes**: `\` (horizontal), `-` (vertical)
- **Windows/panes start at**: 8 (not 0)
- **Theme**: Catppuccin Mocha
- **Plugin manager**: TPM (Tmux Plugin Manager)
- Important plugins: vim-tmux-navigator, tmux-resurrect, tmux-continuum

Reload config: `Ctrl+g` then `r`

### Tool Version Management

Uses `mise` (formerly rtx) for runtime management:

- Configuration: `mise/config.toml`
- Managed tools: lua, node, python, go, rust
- Auto-installs on directory entry
- Local overrides: `~/.mise.local.toml` (not tracked)

### OpenCode Integration

OpenCode is a VS Code-like TUI configured in `opencode/opencode.jsonc`:

- Theme: Catppuccin
- Model: claude-sonnet-4-5
- Leader key: `Ctrl+x`
- Configuration includes custom keybindings for all major operations

## Important Implementation Details

### When Modifying Setup Scripts

1. **Idempotency**: Functions should be safe to run multiple times
2. **Check before install**: Use `command -v` to check if tools exist
3. **Symlinks**: Use `ln -nsf` (force, no-dereference, symbolic)
4. **Directory creation**: Check with `[[ -d path ]] || mkdir -p`
5. **Function naming**: Follow pattern `setup_<tool>_config` or `install_<package>`

### Common Aliases to Remember

From `zsh/aliases.zsh`:

- `ls` → `eza --color=always --icons=always --grid --across`
- `cd` → `z` (zoxide, smart directory jumping)
- `tree` → `eza -T` (excludes .git and node_modules)
- `nvimrc` → opens nvim config directory
- `dotfiles` → `cd ~/.dotfiles/`

### macOS-Specific Settings

The `setup_mac_key_repeat()` function modifies keyboard settings:

- Disables press-and-hold for accent characters
- Sets initial key repeat to 13
- Sets key repeat rate to 1
- These require app restart to take effect

## Working with This Repository

### Adding a New Tool Configuration

1. Create directory: `mkdir <tool>`
2. Add configuration files in that directory
3. Add setup function to `setup.sh`:
   ```bash
   function setup_<tool>_config() {
     echo "Setting up <tool> config"
     ln -nsf "$HOME"/.dotfiles/<tool> "$XDG_CONFIG_HOME"
   }
   ```
4. Add command-line flag handling in `initial_setup()`
5. Include in `setup_all()` or `setup_all_configs()` if appropriate
6. Add cleanup function to `clean.sh`

### Modifying Existing Configurations

- Neovim plugins: Add/modify files in `nvim/lua/plugins/`
- Shell aliases: Edit `zsh/aliases.zsh`
- Environment variables: Edit `zsh/exports.zsh`
- tmux bindings: Edit `tmux/tmux.conf`
- Installed packages: Modify `install_other_necessary_packages()` in `setup.sh`

### Testing Workflow

1. Make changes to config files
2. If testing setup: run specific setup command
3. If testing cleanup: use `--*-configs-only` flags first
4. Verify symlinks: `ls -la ~/.config/<tool>`
5. Test tool functionality
6. Commit changes if working correctly

### Dependencies Between Components

- **zsh** depends on: Homebrew-installed plugins (powerlevel10k, syntax-highlighting, etc.)
- **tmux** depends on: TPM (Tmux Plugin Manager) cloned during setup
- **neovim** depends on: lazy.nvim (auto-installed on first run)
- **mise** manages: lua, node, python, go, rust versions
- **All configs** depend on: XDG environment variables set in `.zshenv`

## Important Paths

- Repository: `~/.dotfiles/`
- Configs: `~/.config/` (or `$XDG_CONFIG_HOME`)
- Zsh history: `~/.local/state/zsh/history`
- Zsh cache: `~/.cache/zsh/`
- Mise local config: `~/.mise.local.toml`
- Zsh local config: `~/.dotfiles/zsh/local-config/config.zsh`
