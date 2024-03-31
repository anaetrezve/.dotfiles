# XDG Paths
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

# ZSH Paths
export ZDOTDIR=$HOME/.config/zsh
export ZSH_CACHE_DIR=$XDG_CACHE_HOME/zsh
export ZSH=$HOME/.config/zsh

eval "$(/opt/homebrew/bin/brew shellenv)"
