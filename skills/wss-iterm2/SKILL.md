---
name: wss-iterm2
description: Use this skill when the user wants to configure iTerm2 appearance — font, colors, window size, transparency.
version: 1.0.0
---

# wss-iterm2

Sets up iTerm2 with a polished appearance profile: Catppuccin Mocha color scheme,
JetBrains Mono Nerd Font, larger window, and subtle transparency/blur.

## When This Skill Applies

- User wants to set up or improve iTerm2 appearance
- User wants a Nerd Font installed for their terminal
- User wants a color scheme / theme applied to iTerm2

## Entry Point

```bash
bash skills/wss-iterm2/wss-iterm2.sh
```

## What It Does

1. Installs `font-jetbrains-mono-nerd-font` via Homebrew cask
2. Copies `profile.json` into `~/Library/Application Support/iTerm2/DynamicProfiles/`
3. Sets the `ws_config` profile as the iTerm2 default

## Profile Settings

| Setting | Value |
|---------|-------|
| Color scheme | Catppuccin Mocha |
| Font | JetBrains Mono Nerd Font 14pt |
| Window size | 220 columns × 50 rows |
| Transparency | 8% |
| Blur | enabled (radius 8) |
| Scrollback | 10,000 lines |

## After Running

Restart iTerm2 (Cmd+Q and reopen) to apply the profile.

## Files

```
wss-iterm2/
├── SKILL.md
├── profile.json        # iTerm2 Dynamic Profile (Catppuccin Mocha)
└── wss-iterm2.sh       # install script
```
