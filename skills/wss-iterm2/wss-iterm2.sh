#!/usr/bin/env bash
# Skill: wss-iterm2
# Installs JetBrains Mono Nerd Font and applies ws_config iTerm2 profile
# (Catppuccin Mocha, 14pt font, 220x50 window, slight transparency/blur).
# Idempotent: safe to run multiple times.

set -e

SKILL_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DYNAMIC_PROFILES_DIR="$HOME/Library/Application Support/iTerm2/DynamicProfiles"
PROFILE_DST="$DYNAMIC_PROFILES_DIR/ws_config.json"

# --- 1. install Nerd Font ---
FONT_CASK="font-jetbrains-mono-nerd-font"

if brew list --cask "$FONT_CASK" &>/dev/null; then
    echo "[skip] $FONT_CASK already installed"
else
    echo "Installing $FONT_CASK..."
    brew tap homebrew/cask-fonts 2>/dev/null || true
    brew install --cask "$FONT_CASK"
    echo "[ok] $FONT_CASK installed"
fi

# --- 2. symlink Dynamic Profile ---
mkdir -p "$DYNAMIC_PROFILES_DIR"

REPO_ROOT="$(cd "$SKILL_DIR/../.." && pwd)"
PROFILE_SRC="$REPO_ROOT/dotfiles/wss-iterm2/profile.json"

if [ -L "$PROFILE_DST" ] && [ "$(readlink "$PROFILE_DST")" = "$PROFILE_SRC" ]; then
    echo "[skip] iTerm2 dynamic profile already linked"
else
    ln -sf "$PROFILE_SRC" "$PROFILE_DST"
    echo "[ok] iTerm2 dynamic profile linked -> $PROFILE_DST"
fi

# --- 3. set ws_config as default profile ---
defaults write com.googlecode.iterm2 "Default Bookmark Guid" "ws-config-iterm2-profile-001"
echo "[ok] ws_config set as default iTerm2 profile"

echo ""
echo "Done."
echo "Restart iTerm2 (or Cmd+Q and reopen) to apply the profile."
echo "Profile: ws_config (Catppuccin Mocha, JetBrains Mono Nerd Font 14, 220x50)"
