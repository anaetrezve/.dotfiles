# --- Zsh Completion Setup ---

# Add Homebrew completions to FPATH
if [ -n "$HOMEBREW_PREFIX" ] && [ -d "$HOMEBREW_PREFIX/share/zsh/site-functions" ]; then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"
fi

autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit

# tmux completion
if command -v tmux &>/dev/null; then
  # If Homebrew's completion exists, FPATH already includes it.
  if [ -f "$HOMEBREW_PREFIX/share/zsh/site-functions/_tmux" ]; then
    # Already available via FPATH
    :
  # If installed elsewhere, try to source it manually (adjust path as needed)
  elif [ -f "/usr/share/zsh/site-functions/_tmux" ]; then
    fpath=(/usr/share/zsh/site-functions $fpath)
  fi
fi

# mise (multi-language version manager)
if command -v mise &>/dev/null; then
  eval "$(mise completion zsh)"
fi

# nvm (Node Version Manager)
if [ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ]; then
  source "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"
elif [ -n "$NVM_DIR" ] && [ -s "$NVM_DIR/bash_completion" ]; then
  source "$NVM_DIR/bash_completion"
fi

# pnpm
if command -v pnpm &>/dev/null; then
  eval "$(pnpm completion zsh)"
fi

# yarn
if command -v yarn &>/dev/null; then
  eval "$(yarn completion zsh 2>/dev/null)"
fi

# npm
if command -v npm &>/dev/null; then
  eval "$(npm completion)"
fi

# pipx
# if command -v pipx &>/dev/null; then
#   eval "$(register-python-argcomplete pipx)"
# fi

# ngrok
if command -v ngrok &>/dev/null; then
  eval "$(ngrok completion)"
fi

# fzf
if command -v fzf &>/dev/null && [ -f "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh" ]; then
  source "$HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh"
fi

# git (ensure zsh's _git is loaded)
if [ -f "$HOMEBREW_PREFIX/share/zsh/site-functions/_git" ]; then
  autoload -Uz _git
fi

# gh (GitHub CLI)
if command -v gh &>/dev/null; then
  eval "$(gh completion -s zsh)"
fi

# docker
if command -v docker &>/dev/null; then
  source <(docker completion zsh)
fi

# --- Kubernetes-related tools ---

# kubectl
if command -v kubectl &>/dev/null; then
  source <(kubectl completion zsh)
fi

# helm
if command -v helm &>/dev/null; then
  source <(helm completion zsh)
fi

# k9s (Kubernetes terminal UI)
if command -v k9s &>/dev/null; then
  source <(k9s completion zsh)
fi

# minikube
if command -v minikube &>/dev/null; then
  source <(minikube completion zsh)
fi

# kustomize
if command -v kustomize &>/dev/null; then
  source <(kustomize completion zsh)
fi

# --- Cloud & Infra tools ---

# terraform
if command -v terraform &>/dev/null; then
  complete -C terraform terraform
fi

# awscli
if command -v aws_completer &>/dev/null; then
  complete -C "$(command -v aws_completer)" aws
fi

# gcloud
if command -v gcloud &>/dev/null; then
  source <(gcloud completion zsh)
fi

# az (Azure CLI)
if command -v az &>/dev/null; then
  source <(az completion -zsh)
fi

# doctl (DigitalOcean CLI)
if command -v doctl &>/dev/null; then
  source <(doctl completion zsh)
fi

