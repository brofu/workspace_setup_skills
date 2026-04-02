#!/usr/bin/env bash
# Skill: wss-git-ssh
# Configures SSH for a GitHub account.
# Idempotent: safe to run multiple times.

set -e

# --- prompt for inputs ---
read -rp "GitHub username: " GITHUB_USER
read -rp "SSH key path (e.g. ~/.ssh/id_github_foo): " SSH_KEY
SSH_KEY="${SSH_KEY/#\~/$HOME}"  # expand ~ if provided

if [ -z "$GITHUB_USER" ] || [ -z "$SSH_KEY" ]; then
    echo "Error: username and SSH key path are required." >&2
    exit 1
fi

if [ ! -f "$SSH_KEY" ]; then
    echo "Error: SSH key not found at $SSH_KEY" >&2
    exit 1
fi

SSH_CONFIG="$HOME/.ssh/config"
MARKER="# github $GITHUB_USER"

if grep -q "$MARKER" "$SSH_CONFIG" 2>/dev/null; then
    echo "[skip] SSH config for $GITHUB_USER already present"
else
    cat >> "$SSH_CONFIG" <<EOF

$MARKER
Host github.com
  HostName github.com
  User git
  IdentityFile $SSH_KEY
  AddKeysToAgent yes
  UseKeychain yes
EOF
    echo "[ok] SSH config added for $GITHUB_USER"
fi

echo ""
echo "Testing connection..."
ssh -T git@github.com 2>&1 || true
