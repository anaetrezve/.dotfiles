# Agent Guidelines for .dotfiles Repository

## Build & Test Commands
- **Setup all configs**: `./setup.sh --all` or specific: `./setup.sh --setup-neovim --setup-zsh`
- **Test setup script**: `./setup.sh --help` (dry-run, validates flags)
- **Clean configs**: `./clean.sh --configs-only` (destructive, use with caution)
- **Validate symlinks**: Check `~/.config/` for broken symlinks after setup

## Code Style Guidelines

### Shell Scripts (Bash/ZSH)
- Use `#!/usr/bin/env bash` shebang for portability
- Functions: `function name() { ... }` with lowercase snake_case names
- Local variables: Use `local` keyword (e.g., `local app_name="$1"`)
- Error handling: Check exit codes with `if [ $? -eq 0 ]; then`
- Quote variables: Always use `"$variable"` to prevent word splitting
- Comments: Single-line `#` with space after hash

### Lua (Neovim)
- Module structure: Return tables with functions (e.g., `local M = {}; return M`)
- Use `local` for all variables/functions to avoid global namespace pollution
- Formatting: 2-space indentation, prefer double quotes for strings
- Comments: LuaDoc annotations for functions (e.g., `--- @param mode string`)
- Keymaps: Use descriptive `desc` field for which-key integration
- Plugin specs: Follow lazy.nvim structure with `keys`, `opts`, `config` fields
