# Options
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

source $ZDOTDIR/exports.zsh
source $ZDOTDIR/aliases.zsh
source $ZDOTDIR/completion.zsh
# Plugins
source $ZDOTDIR/.p10k.zsh
source $(brew --prefix)/share/powerlevel10k/powerlevel10k.zsh-theme
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $(brew --prefix)/share/zsh-you-should-use/you-should-use.plugin.zsh

# plugins=(git z zsh-autosuggestions zsh-syntax-highlighting)
# zstyle ':omz:update' mode auto

# VIM MODE
bindkey -v
bindkey ^R history-incremental-search-backward
bindkey ^S history-incremental-search-forward

# zsh-history-substring-search keybinding to up and down arrow
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down



