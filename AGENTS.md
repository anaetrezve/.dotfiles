# Agent Guidelines for .dotfiles Repository

## Research Requirements (MANDATORY)

Before answering ANY question or performing ANY task, you MUST gather up-to-date information using web search and available tools:

### Research Priority Order
1. **Official Documentation** - Always check official docs first (e.g., neovim.io, lua.org, tmux.github.io)
2. **Source Code** - When available, examine actual source code on GitHub for accurate implementation details
3. **GitHub Issues/Discussions** - Check for known issues, workarounds, and community solutions
4. **Stack Overflow** - For common problems and verified solutions
5. **Reddit** (r/neovim, r/vim, r/zsh, r/tmux, etc.) - Community insights and real-world usage patterns
6. **Blog Posts & Tutorials** - Recent articles with practical examples
7. **Forums & Community Sites** - Tool-specific forums and discussion boards

### Research Guidelines
- **Always verify currency**: Information older than 6 months may be outdated for rapidly evolving tools
- **Cross-reference sources**: Don't rely on a single source; verify with multiple references
- **Check version compatibility**: Ensure solutions match the versions in use (check `mise/config.toml` for versions)
- **Prefer primary sources**: Official repos and docs over third-party summaries
- **Note breaking changes**: Many tools (especially Neovim plugins) have frequent breaking changes

### When to Search
- Configuration questions → Search for latest recommended practices
- Error troubleshooting → Search for specific error messages + tool versions
- Plugin/tool setup → Check official README and recent GitHub issues
- Best practices → Look for current community consensus
- API/syntax questions → Verify against current documentation

### Tools Available for Research
- `WebSearch` - Search the internet for current information
- `WebFetch` - Fetch specific URLs (docs, GitHub READMEs, etc.)
- `mcp__plugin_doctolib-base_context7__query-docs` - Query library documentation
- `mcp__plugin_doctolib-base_context7__resolve-library-id` - Find library documentation

**IMPORTANT**: Do NOT rely solely on training data. Always search for current information, especially for:
- Neovim plugins (APIs change frequently)
- Package versions and compatibility
- CLI tool flags and options
- Configuration file formats

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
