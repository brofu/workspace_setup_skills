---
name: wss-ohmyzsh
description: Use this skill when the user wants to set up Oh-My-Zsh with Powerlevel10k theme and useful plugins.
version: 1.0.0
---

# wss-ohmyzsh

Installs Oh-My-Zsh, Powerlevel10k theme, and essential plugins, then wires them
into the managed zshrc (`ws_config/dotfiles/zsh/zshrc`).

## When This Skill Applies

- User wants to install or configure Oh-My-Zsh
- User wants a Powerlevel10k prompt
- User wants zsh-autosuggestions or zsh-syntax-highlighting
- User wants to upgrade from a basic Oh-My-Zsh theme (e.g. robbyrussell)

## Entry Point

```bash
bash skills/wss-ohmyzsh/wss-ohmyzsh.sh
```

## What It Does

1. Installs Oh-My-Zsh (skipped if already present)
2. Installs Powerlevel10k into `~/.oh-my-zsh/custom/themes/`
3. Installs plugins into `~/.oh-my-zsh/custom/plugins/`:
   - `zsh-autosuggestions`
   - `zsh-syntax-highlighting`
4. Removes bare oh-my-zsh lines from old configs (workspace_config era)
5. Appends a `source` of `zshrc_omz.sh` into the managed zshrc

## Plugins Enabled

| Plugin | Description |
|--------|-------------|
| `git` | git aliases and prompt info |
| `zsh-autosuggestions` | fish-style inline suggestions |
| `zsh-syntax-highlighting` | command syntax coloring |
| `z` | jump to frecent directories |
| `docker` | docker completions |
| `kubectl` | kubectl completions |

## After Running

```bash
p10k configure   # interactive prompt setup wizard
source ~/.zshrc
```

## Relationship with wss-iterm2

Run `wss-iterm2` first — Powerlevel10k renders Nerd Font icons that require
the JetBrains Mono Nerd Font installed by that skill.

## Files

```
wss-ohmyzsh/
├── SKILL.md
└── wss-ohmyzsh.sh              # install script

dotfiles/zsh/
└── zshrc_omz.sh                # oh-my-zsh + p10k config block (sourced by zshrc)
```
