#!/usr/bin/env bash
set -e

REAL_SCRIPT="$(readlink -f "${BASH_SOURCE[0]}")"
REPO_ROOT="$(cd "$(dirname "$REAL_SCRIPT")/../.." && pwd)"
ZSHRC="$REPO_ROOT/dotfiles/zsh/zshrc"
SOURCE_LINE="source $REPO_ROOT/skills/wss-git-alias/git_alias.sh"

if grep -qF "wss-git-alias/git_alias.sh" "$ZSHRC"; then
    echo "Git aliases already sourced in $ZSHRC — skipping."
else
    echo "$SOURCE_LINE" >> "$ZSHRC"
    echo "Appended to $ZSHRC: $SOURCE_LINE"
    source ~/.zshrc
    echo "Reloaded ~/.zshrc"
fi
