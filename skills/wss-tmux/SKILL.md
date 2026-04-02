---
name: wss-tmux
description: This skill should be used when the user asks to "install tmux", "setup tmux", "configure tmux", "setup tx_load", or mentions tmux is missing or not working.
version: 3.0.0
---

# wss-tmux

Installs tmux (if needed) and configures it with symlinks and shell aliases.

## When This Skill Applies

- User asks to install or set up tmux
- User gets `command not found: tmux` or `command not found: tx_load`
- User wants to configure tmux from scratch

## Entry Point

```bash
bash skills/wss-tmux/wss-tmux.sh
```

## What It Does

### 1. Install tmux (skipped if already installed)

Detects OS and installs via the appropriate package manager (brew / apt / yum / pacman).

### 2. Symlink managed zshrc → ~/.zshrc

```
dotfiles/zsh/zshrc  →  ~/.zshrc
```

If `~/.zshrc` already exists and is not a symlink, it is backed up to `~/.zshrc.bak` first.

### 3. Symlink tmux config files

```
dotfiles/tmux/.tmux.conf  →  ~/.tmux.conf
dotfiles/tmux/.auto_load  →  ~/.tmux_auto_load
```

### 4. Add aliases to managed zshrc

Appended once (idempotent) to `dotfiles/zsh/zshrc`:

```bash
# tmux aliases (ws_config)
alias tx='tmux -2'
alias tx_load='bash $HOME/.tmux_auto_load'
```

### 5. Reload shell

Tell the user to run:
```bash
source ~/.zshrc
```

## Verification

```bash
tmux -V       # should print tmux version
type tx_load  # should resolve to alias
```

## Dotfiles Layout

```
ws_config/
└── dotfiles/
    ├── zsh/
    │   └── zshrc          # managed zshrc — symlinked to ~/.zshrc
    └── tmux/
        ├── .tmux.conf     # tmux settings — symlinked to ~/.tmux.conf
        └── .auto_load     # session bootstrap — symlinked to ~/.tmux_auto_load
```

## Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `tx` | `tmux -2` | Open tmux with 256-color support |
| `tx_load` | `bash ~/.tmux_auto_load` | Bootstrap standard sessions and attach |
