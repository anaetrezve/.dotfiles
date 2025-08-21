#!/usr/bin/env sh

# Helper: add if dir exists and not already in PATH
add_to_path() {
  [ -d "$1" ] && case ":$PATH:" in
    *":$1:"*) ;; # already there
    *) export PATH="$1:$PATH" ;;
  esac
}

# Set HOMEBREW_PREFIX if not set
if [ -z "$HOMEBREW_PREFIX" ]; then
  if [ -d "/opt/homebrew" ]; then
    export HOMEBREW_PREFIX="/opt/homebrew"
  elif [ -d "/usr/local" ]; then
    export HOMEBREW_PREFIX="/usr/local"
  elif [ -d "/home/linuxbrew/.linuxbrew" ]; then
    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
  fi
fi

# Multi-language managers (highest priority)
# add_to_path "$HOME/.local/share/mise/shims"   # mise
# add_to_path "$HOME/.asdf/shims"               # asdf
# add_to_path "$HOME/.rtx/shims"                # rtx

# Node (nodenv, nvm, volta, nodebrew)
add_to_path "$HOME/.nodenv/shims"
add_to_path "$HOME/.nodebrew/current/bin"
if [ -d "$HOME/.nvm/versions/node" ]; then
  for nvmbin in "$HOME/.nvm/versions/node"/*/bin; do
    add_to_path "$nvmbin"
  done
fi
add_to_path "$HOME/.volta/bin"

# Python (pyenv)
add_to_path "$HOME/.pyenv/shims"

# Ruby (rbenv)
add_to_path "$HOME/.rbenv/shims"

# RubyGems user bin
if command -v ruby >/dev/null 2>&1; then
  GEM_USER_DIR="$(ruby -e 'print Gem.user_dir' 2>/dev/null)"
  [ -n "$GEM_USER_DIR" ] && add_to_path "$GEM_USER_DIR/bin"
fi

# Go
add_to_path "$HOME/go/bin"

# Rust (cargo)
add_to_path "$HOME/.cargo/bin"

# NPM (XDG or fallback)
add_to_path "${XDG_DATA_HOME:-$HOME/.local/share}/npm/bin"

# Yarn
add_to_path "$HOME/.yarn/bin"

# Neovim, mason and Bob
add_to_path "$HOME/.local/share/neovim/bin"
add_to_path "$HOME/.local/share/nvim/mason/bin"
add_to_path "$HOME/.local/share/bob/nvim-bin"

# Local user bin
add_to_path "$HOME/.local/bin"

# Homebrew (Apple Silicon, Intel, Linux)
if [ -d "/opt/homebrew/bin" ]; then
  add_to_path "/opt/homebrew/bin"       # Apple Silicon
elif [ -d "/usr/local/bin" ]; then
  add_to_path "/usr/local/bin"          # Intel Mac
elif [ -d "/home/linuxbrew/.linuxbrew/bin" ]; then
  add_to_path "/home/linuxbrew/.linuxbrew/bin" # Linux
fi

# Always add /usr/local/bin and /usr/bin as fallback
add_to_path "/usr/local/bin"
add_to_path "/usr/bin"

export KEYTIMEOUT=1
export EDITOR=nvim
export MANPAGER='nvim +Man!'
export MANWIDTH=999

export DOTFILES="$HOME/.dotfiles"

export STARSHIP_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/starship/starship.toml"

# export NVM_DIR="${XDG_CONFIG_HOME:-$HOME/.nvm}"
# [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" # Homebrew nvm

