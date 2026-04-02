---
name: wss-git-alias
description: Use this skill when the user wants to set up git shell aliases (gs, gb, ga, gct, gd, gr, gl, gco, gpl, gph, gcf).
version: 1.0.0
---

# wss-git-alias

Appends git shell aliases to `~/.zshrc` (which is symlinked to `ws_config/dotfiles/zsh/zshrc`).

## When This Skill Applies

- User wants to set up git shortcuts in the shell
- User wants `gs`, `gct`, `gpl`, etc. to work in the terminal

## Entry Point

```bash
bash skills/wss-git-alias/wss-git-alias.sh
```

## What It Does

1. Checks if git aliases are already present in `~/.zshrc` (idempotent)
2. If not, appends the alias block

## Aliases Added

| Alias | Command          |
|-------|-----------------|
| `gs`  | `git status`    |
| `gb`  | `git branch`    |
| `ga`  | `git add`       |
| `gct` | `git commit -m` |
| `gd`  | `git diff`      |
| `gr`  | `git remote -v` |
| `gl`  | `git log`       |
| `gco` | `git checkout`  |
| `gpl` | `git pull`      |
| `gph` | `git push`      |
| `gcf` | `git config`    |

## After Running

Reload the shell to activate:
```bash
source ~/.zshrc
```
