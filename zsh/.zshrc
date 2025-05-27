# =====================
# ALIASES AND EXPORTS
# =====================
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/exports.zsh
source $ZDOTDIR/completion.zsh

# =====================
# HISTORY SETTINGS
# =====================
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
HISTDUP=erase
HISTFILE=$XDG_STATE_HOME/zsh/history

# Use XDG dirs for completion and history files

# History Options
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt appendhistory
setopt sharehistory
setopt hist_save_no_dups
setopt hist_find_no_dups

# =====================
# AUTO-COMPLETION SETTINGS
# =====================
autoload -U compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME"/zsh/zcompcache
zmodload zsh/complist
compinit -d $XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION
_comp_options+=(globdots) # Include hidden files.

# =====================
# PLUGINS
# =====================

source $ZDOTDIR/.p10k.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh

# plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
# zstyle ':omz:update' mode auto

# VIM MODE
# bindkey -v
# bindkey ^R history-incremental-search-backward
# bindkey ^S history-incremental-search-forward

# Keybindings
# bindkey -e
# bindkey '^p' history-search-backward
# bindkey '^n' history-search-forward
# bindkey '^[w' kill-region

# zsh-history-substring-search keybinding to up and down arrow
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
# bindkey -M vicmd 'k' history-substring-search-up
# bindkey -M vicmd 'j' history-substring-search-down

# =====================
# NVM CONFIGURATION
# =====================
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# =====================
# ZOXIDE INTEGRATION
# =====================
if command -v "zoxide" &>/dev/null; then
  eval "$(zoxide init zsh)"
fi

# =====================
# LOCAL CONFIGURATION
# =====================
if [[ -r "$ZDOTDIR/local-config/config.zsh" ]]; then
  source "$ZDOTDIR/local-config/config.zsh"
fi

# =====================
# STARSHIP PROMPT
# =====================
# if command -v starship &>/dev/null; then
#   eval "$(starship init zsh)"
# fi
