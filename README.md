# workspace_setup_skills

A collection of workspace setup skills for bootstrapping a new machine.

## Operation Workflow (New Machine Setup)

**Step 1 — Bootstrap**

```bash
bash bootstrap.sh
```

- Symlinks `~/.zshrc` → `dotfiles/zsh/zshrc`
- Registers all skills into `~/.claude/skills/`

**Step 2 — Run whichever skills you need**

Tell Claude (or run the scripts directly):

```bash
bash skills/wss-iterm2/wss-iterm2.sh       # iTerm2 appearance + Nerd Font
bash skills/wss-ohmyzsh/wss-ohmyzsh.sh     # Oh-My-Zsh + Powerlevel10k
bash skills/wss-tmux/wss-tmux.sh           # tmux install + config
bash skills/wss-git-alias/wss-git-alias.sh # git shortcuts
bash skills/wss-git-ssh/wss-git-ssh.sh     # GitHub SSH access
```

Skills are independent — run any subset in any order.

**Step 3 — Automatic**

Each skill appends its source line to `zshrc` and reloads it immediately.
Since `~/.zshrc` is already symlinked to the repo, changes take effect in the current shell right away.

> After `wss-ohmyzsh`: run `p10k configure` once to set up your prompt style.

---

## How to Use with Claude

These are [Claude Code](https://claude.ai/code) skills. Once bootstrapped, just tell Claude what you want — it will invoke the right skill automatically.

---

## Available Skills

### wss-iterm2 — iTerm2 Appearance

Sets up iTerm2 with Catppuccin Mocha colors, JetBrains Mono Nerd Font, and a comfortable window size.

**When to use:** Setting up iTerm2 on a new machine or refreshing its appearance.

Just tell Claude: *"set up iTerm2"* or *"configure iTerm2 appearance"*.

What it does:
- Installs JetBrains Mono Nerd Font via `brew install --cask`
- Installs a Dynamic Profile (Catppuccin Mocha, 14pt font, 220×50, 8% transparency + blur)
- Sets the profile as the iTerm2 default

Restart iTerm2 after running to apply.

---

### wss-ohmyzsh — Oh-My-Zsh + Powerlevel10k

Installs Oh-My-Zsh with Powerlevel10k theme and essential plugins.

**When to use:** Setting up or upgrading the Zsh prompt on a new machine.

Just tell Claude: *"set up oh-my-zsh"* or *"configure powerlevel10k"*.

What it does:
- Installs Oh-My-Zsh (skipped if present)
- Installs Powerlevel10k theme
- Installs `zsh-autosuggestions` and `zsh-syntax-highlighting`
- Wires everything into the managed zshrc

After running: `p10k configure` to set up the prompt interactively.

> Run `wss-iterm2` first — Powerlevel10k needs the Nerd Font to render icons.

---

### wss-git-ssh — Configure GitHub SSH

Sets up SSH access for a GitHub account.

**When to use:** SSH permission denied on git push/pull, or setting up a new GitHub account.

Just tell Claude: *"set up SSH for my GitHub account"* or *"configure git SSH"*.

Prompts for your GitHub username and SSH key path, then adds a `Host github.com` entry to `~/.ssh/config` and tests the connection.

---

### wss-tmux — Install & Configure tmux

Installs tmux and sets up config, dotfiles, and shell aliases.

**When to use:** `command not found: tmux` or `tx_load`, or setting up tmux from scratch.

Just tell Claude: *"install tmux"*, *"set up tmux"*, or *"configure tx_load"*.

What it does:
- Installs tmux via the appropriate package manager (brew / apt / yum / pacman)
- Symlinks `dotfiles/wss-tmux/.tmux.conf` → `~/.tmux.conf`
- Symlinks `dotfiles/wss-tmux/.auto_load` → `~/.tmux_auto_load`
- Appends `tx` and `tx_load` aliases to the managed zshrc

After running, reload your shell:

```bash
source ~/.zshrc
```

| Alias | Description |
|-------|-------------|
| `tx` | Open tmux with 256-color support |
| `tx_load` | Bootstrap standard tmux sessions and attach |

---

### wss-git-alias — Git Shell Aliases

Adds common git shortcut aliases to the shell.

**When to use:** Setting up git shortcuts on a new machine.

Just tell Claude: *"set up git aliases"* or *"configure git shortcuts"*.

What it does:
- Appends a `source` line for `git_alias.sh` into the managed zshrc
- Auto-reloads `~/.zshrc` so aliases are available immediately

| Alias | Command |
|-------|---------|
| `gs` | `git status` |
| `gb` | `git branch` |
| `ga` | `git add` |
| `gct` | `git commit -m` |
| `gd` | `git diff` |
| `gr` | `git remote -v` |
| `gl` | `git log` |
| `gco` | `git checkout` |
| `gpl` | `git pull` |
| `gph` | `git push` |
| `gcf` | `git config` |

---

## Layout

```
ws_config/
├── bootstrap.sh                        # step 1: symlink zshrc + register skills
├── dotfiles/
│   ├── zsh/
│   │   └── zshrc                       # entry point — symlinked to ~/.zshrc
│   ├── wss-tmux/
│   │   ├── .tmux.conf
│   │   ├── .auto_load
│   │   └── tmux_alias.sh
│   ├── wss-git-alias/
│   │   └── git_alias.sh
│   ├── wss-ohmyzsh/
│   │   └── zshrc_omz.sh
│   └── wss-iterm2/
│       └── profile.json                # symlinked to iTerm2 DynamicProfiles
└── skills/                             # installers only
    ├── wss-git-alias/
    │   ├── SKILL.md
    │   └── wss-git-alias.sh
    ├── wss-git-ssh/
    │   ├── SKILL.md
    │   └── wss-git-ssh.sh
    ├── wss-iterm2/
    │   ├── SKILL.md
    │   └── wss-iterm2.sh
    ├── wss-ohmyzsh/
    │   ├── SKILL.md
    │   └── wss-ohmyzsh.sh
    └── wss-tmux/
        ├── SKILL.md
        ├── config.sh
        └── wss-tmux.sh
```
