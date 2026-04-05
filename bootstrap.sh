#!/usr/bin/env bash
# Bootstrap ws_config skills into ~/.claude/skills/
# Idempotent: safe to run multiple times.

set -e

WS_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$WS_CONFIG_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"

mkdir -p "$SKILLS_DST"

# --- symlink managed zshrc -> ~/.zshrc ---
ZSHRC_SRC="$WS_CONFIG_DIR/dotfiles/zsh/zshrc"
ZSHRC_DST="$HOME/.zshrc"

if [ -L "$ZSHRC_DST" ] && [ "$(readlink "$ZSHRC_DST")" = "$ZSHRC_SRC" ]; then
    echo "[skip] ~/.zshrc already linked"
else
    [ -f "$ZSHRC_DST" ] && ! [ -L "$ZSHRC_DST" ] && cp "$ZSHRC_DST" "$ZSHRC_DST.bak" && echo "[backup] ~/.zshrc.bak created"
    ln -sf "$ZSHRC_SRC" "$ZSHRC_DST"
    echo "[ok] ~/.zshrc -> $ZSHRC_SRC"
fi

# --- register skills into ~/.claude/skills/ ---
for skill_dir in "$SKILLS_SRC"/*/; do
    skill_name="$(basename "$skill_dir")"
    dst="$SKILLS_DST/$skill_name"

    if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$skill_dir" ]; then
        echo "[skip] $skill_name already linked"
    else
        ln -sf "$skill_dir" "$dst"
        echo "[ok] $skill_name -> $skill_dir"
    fi
done

echo ""
echo "Done. Skills registered in $SKILLS_DST"
