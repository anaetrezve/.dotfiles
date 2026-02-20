eval "$(/opt/homebrew/bin/brew shellenv)"

# =====================
# ZOXIDE INTEGRATION
# =====================
if command -v "zoxide" &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# =====================
# STARSHIP PROMPT (initialized in loaders.zsh)
# =====================

# Activate mise in Zsh only if installed
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi
