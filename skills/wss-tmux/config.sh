#!/usr/bin/env bash
# Skill: configure tmux
# - Symlinks dotfiles/zsh/zshrc -> ~/.zshrc
# - Symlinks .tmux.conf -> ~/.tmux.conf
# - Symlinks .auto_load -> ~/.tmux_auto_load
# - Adds tx / tx_load aliases to the managed zshrc
# Idempotent: safe to run multiple times.

set -e

SKILL_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WS_CONFIG_DIR="$(cd "$SKILL_DIR/../.." && pwd)"
DOTFILES_TMUX="$WS_CONFIG_DIR/dotfiles/tmux"
DOTFILES_ZSH="$WS_CONFIG_DIR/dotfiles/zsh"

# --- 1. symlink managed zshrc -> ~/.zshrc ---
ZSHRC_SRC="$DOTFILES_ZSH/zshrc"
ZSHRC_DST="$HOME/.zshrc"

if [ -L "$ZSHRC_DST" ] && [ "$(readlink "$ZSHRC_DST")" = "$ZSHRC_SRC" ]; then
    echo "[skip] ~/.zshrc already linked"
else
    [ -f "$ZSHRC_DST" ] && ! [ -L "$ZSHRC_DST" ] && cp "$ZSHRC_DST" "$ZSHRC_DST.bak" && echo "[backup] ~/.zshrc.bak created"
    ln -sf "$ZSHRC_SRC" "$ZSHRC_DST"
    echo "[ok] ~/.zshrc -> $ZSHRC_SRC"
fi

# --- 2. symlink .tmux.conf ---
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

# --- 4. add aliases to managed zshrc ---
MARKER="# tmux aliases (ws_config)"

if grep -q "$MARKER" "$ZSHRC_SRC" 2>/dev/null; then
    echo "[skip] aliases already present in managed zshrc"
else
    printf '\n%s\n%s\n%s\n' \
        "$MARKER" \
        "alias tx='tmux -2'" \
        "alias tx_load='bash \$HOME/.tmux_auto_load'" \
        >> "$ZSHRC_SRC"
    echo "[ok] aliases added to managed zshrc"
    source ~/.zshrc
    echo "[ok] Reloaded ~/.zshrc"
fi

echo ""
echo "Done."
echo "Then use:  tx_load   — bootstrap tmux sessions"
echo "           tx        — open tmux with 256-color support"
