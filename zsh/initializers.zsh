eval "$(/opt/homebrew/bin/brew shellenv)"

# =====================
# ZOXIDE INTEGRATION
# =====================
if command -v "zoxide" &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# =====================
# STARSHIP PROMPT
# =====================
# if command -v starship &>/dev/null; then
#   eval "$(starship init zsh)"
# fi

# Activate mise in Zsh only if installed
if command -v mise &>/dev/null; then
  eval "$(mise activate zsh)"
fi
