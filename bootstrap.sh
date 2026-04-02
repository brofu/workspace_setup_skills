#!/usr/bin/env bash
# Bootstrap ws_config skills into ~/.claude/skills/
# Idempotent: safe to run multiple times.

set -e

WS_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$WS_CONFIG_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"

mkdir -p "$SKILLS_DST"

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
