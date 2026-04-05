#!/usr/bin/env bash
# Skill: configure tmux
# - Symlinks .tmux.conf -> ~/.tmux.conf
# - Symlinks .auto_load -> ~/.tmux_auto_load
# - Adds tx / tx_load aliases to the managed zshrc
# Idempotent: safe to run multiple times.

set -e

SKILL_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WS_CONFIG_DIR="$(cd "$SKILL_DIR/../.." && pwd)"
DOTFILES_TMUX="$WS_CONFIG_DIR/dotfiles/wss-tmux"
DOTFILES_ZSH="$WS_CONFIG_DIR/dotfiles/zsh"
ZSHRC_SRC="$DOTFILES_ZSH/zshrc"

# --- 1. symlink .tmux.conf ---
TMUX_CONF_SRC="$DOTFILES_TMUX/.tmux.conf"
TMUX_CONF_DST="$HOME/.tmux.conf"

if [ -L "$TMUX_CONF_DST" ] && [ "$(readlink "$TMUX_CONF_DST")" = "$TMUX_CONF_SRC" ]; then
    echo "[skip] ~/.tmux.conf already linked"
else
    [ -f "$TMUX_CONF_DST" ] && ! [ -L "$TMUX_CONF_DST" ] && cp "$TMUX_CONF_DST" "$TMUX_CONF_DST.bak" && echo "[backup] ~/.tmux.conf.bak created"
    ln -sf "$TMUX_CONF_SRC" "$TMUX_CONF_DST"
    echo "[ok] ~/.tmux.conf -> $TMUX_CONF_SRC"
fi

# --- 3. symlink .auto_load ---
AUTO_LOAD_SRC="$DOTFILES_TMUX/.auto_load"
AUTO_LOAD_DST="$HOME/.tmux_auto_load"

if [ -L "$AUTO_LOAD_DST" ] && [ "$(readlink "$AUTO_LOAD_DST")" = "$AUTO_LOAD_SRC" ]; then
    echo "[skip] ~/.tmux_auto_load already linked"
else
    ln -sf "$AUTO_LOAD_SRC" "$AUTO_LOAD_DST"
    chmod +x "$AUTO_LOAD_SRC"
    echo "[ok] ~/.tmux_auto_load -> $AUTO_LOAD_SRC"
fi

# --- 4. source tmux aliases from dotfiles ---
SOURCE_LINE='source "$WS_CONFIG_DIR/dotfiles/wss-tmux/tmux_alias.sh"'

if grep -qF "dotfiles/wss-tmux/tmux_alias.sh" "$ZSHRC_SRC" 2>/dev/null; then
    echo "[skip] tmux aliases already in managed zshrc"
else
    printf '\n%s\n' "$SOURCE_LINE" >> "$ZSHRC_SRC"
    echo "[ok] tmux aliases added to managed zshrc"
    source ~/.zshrc
    echo "[ok] Reloaded ~/.zshrc"
fi

echo ""
echo "Done."
echo "Then use:  tx_load   — bootstrap tmux sessions"
echo "           tx        — open tmux with 256-color support"
