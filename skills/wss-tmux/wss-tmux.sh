#!/usr/bin/env bash
# Skill: wss-tmux
# Installs tmux (if needed) and configures it with symlinks and shell aliases.

set -e

SKILL_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- 1. install tmux ---
if command -v tmux &>/dev/null; then
    echo "[skip] tmux is already installed: $(tmux -V)"
else
    echo "Installing tmux..."

    if [[ "$OSTYPE" == "darwin"* ]]; then
        if command -v brew &>/dev/null; then
            brew install tmux
        else
            echo "Error: Homebrew not found. Install it from https://brew.sh" >&2
            exit 1
        fi
    elif [[ "$OSTYPE" == "linux"* ]]; then
        if command -v apt-get &>/dev/null; then
            sudo apt-get update -qq && sudo apt-get install -y tmux
        elif command -v yum &>/dev/null; then
            sudo yum install -y tmux
        elif command -v pacman &>/dev/null; then
            sudo pacman -S --noconfirm tmux
        else
            echo "Error: No supported package manager found (apt/yum/pacman)." >&2
            exit 1
        fi
    else
        echo "Error: Unsupported OS: $OSTYPE" >&2
        exit 1
    fi

    echo "tmux installed: $(tmux -V)"
fi

# --- 2. configure tmux ---
bash "$SKILL_DIR/config.sh"
