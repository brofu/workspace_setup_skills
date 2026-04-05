#!/usr/bin/env bash
# Skill: wss-ohmyzsh
# Installs Oh-My-Zsh + Powerlevel10k theme + plugins, and wires them into
# the managed zshrc (ws_config/dotfiles/zsh/zshrc).
# Idempotent: safe to run multiple times.

set -e

SKILL_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SKILL_DIR/../.." && pwd)"
ZSHRC="$REPO_ROOT/dotfiles/zsh/zshrc"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# --- 1. install Oh-My-Zsh ---
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "[skip] Oh-My-Zsh already installed"
else
    echo "Installing Oh-My-Zsh..."
    RUNZSH=no CHSH=no sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "[ok] Oh-My-Zsh installed"
fi

# --- 2. install Powerlevel10k ---
P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
if [ -d "$P10K_DIR" ]; then
    echo "[skip] Powerlevel10k already installed"
else
    echo "Installing Powerlevel10k..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
    echo "[ok] Powerlevel10k installed"
fi

# --- 3. install plugins ---
install_plugin() {
    local name="$1"
    local repo="$2"
    local dest="$ZSH_CUSTOM/plugins/$name"
    if [ -d "$dest" ]; then
        echo "[skip] plugin $name already installed"
    else
        echo "Installing plugin $name..."
        git clone --depth=1 "$repo" "$dest"
        echo "[ok] plugin $name installed"
    fi
}

install_plugin "zsh-autosuggestions" \
    "https://github.com/zsh-users/zsh-autosuggestions"
install_plugin "zsh-syntax-highlighting" \
    "https://github.com/zsh-users/zsh-syntax-highlighting"

# --- 4. wire into managed zshrc ---
MARKER="# oh-my-zsh + powerlevel10k (ws_config)"
SOURCE_LINE='source "$WS_CONFIG_DIR/dotfiles/wss-ohmyzsh/zshrc_omz.sh"'

if grep -qF "dotfiles/wss-ohmyzsh/zshrc_omz.sh" "$ZSHRC" 2>/dev/null; then
    echo "[skip] oh-my-zsh block already in managed zshrc"
else
    # remove any old bare oh-my-zsh lines from workspace_config era
    grep -v 'export ZSH=.*oh-my-zsh\|ZSH_THEME=\|source.*oh-my-zsh.sh\|plugins=(' \
        "$ZSHRC" > "$ZSHRC.tmp" && mv "$ZSHRC.tmp" "$ZSHRC"

    printf '\n%s\n%s\n' "$MARKER" "$SOURCE_LINE" >> "$ZSHRC"
    echo "[ok] oh-my-zsh block added to managed zshrc"
fi

echo ""
echo "Done."
echo "Run: p10k configure   — to set up your Powerlevel10k prompt"
echo "Then: source ~/.zshrc"
