# =====================
# MISE CONFIGURATION with .nvmrc support, no file writes
# =====================
autoload -U add-zsh-hook

load-miserc() {
  if [ -f ".tool-versions" ] || [ -f ".mise.toml" ]; then
    mise install
    if command -v node &>/dev/null; then
      echo "mise: Using Node version $(node -v)"
    fi
  elif [ -f ".node-version" ]; then
    local node_version
    node_version="$(cat .node-version | tr -d '[:space:]vV')"
    if [ -n "$node_version" ]; then
      # FIX: Use eval to apply the environment changes
      eval "$(mise shell node@"$node_version")"
      if command -v node &>/dev/null; then
        echo "mise: Using Node version $(node -v) from .node-version"
      fi
    fi
  elif [ -f ".nvmrc" ]; then
    local nvmrc_node_version
    nvmrc_node_version="$(cat .nvmrc | tr -d '[:space:]vV')"
    if [ -n "$nvmrc_node_version" ]; then
      # FIX: Use eval to apply the environment changes
      eval "$(mise shell node@"$nvmrc_node_version")"
      if command -v node &>/dev/null; then
        echo "mise: Using Node version $(node -v) from .nvmrc"
      fi
    fi
  else
    # FIX: Use eval for unsetting as well
    eval "$(mise shell --unset node)"
  fi

  # Ruby section with same fixes
  if [ -f ".tool-versions" ] || [ -f ".mise.toml" ]; then
    mise install
    if command -v ruby &>/dev/null; then
      echo "mise: Using ruby version $(ruby --version)"
    fi
  elif [ -f ".ruby-version" ]; then
    local ruby_version
    ruby_version="$(cat .ruby-version | tr -d '[:space:]vV')"
    if [ -n "$ruby_version" ]; then
      # FIX: Use eval
      eval "$(mise shell ruby@"$ruby_version")"
      if command -v ruby &>/dev/null; then
        echo "mise: Using Ruby version $(ruby --version) from .ruby-version"
      fi
    fi
  elif [ -f "Gemfile" ]; then
    ruby_version="$(grep "^ruby " Gemfile | head -n1 | sed -E "s/^ruby ['\"]([0-9.]+)['\"].*/\1/")"
    if [ -n "$ruby_version" ]; then
      # FIX: Use eval
      eval "$(mise shell ruby@"$ruby_version")"
      if command -v ruby &>/dev/null; then
        echo "mise: Using Ruby version $(ruby -v | awk '{print $2}') from Gemfile"
      fi
    fi
  else
    # FIX: Use eval for unsetting
    eval "$(mise shell --unset ruby)"
  fi
}

add-zsh-hook chpwd load-miserc
load-miserc
