# workspace_setup_skills

A collection of workspace setup skills for bootstrapping a new machine.

## How to Use

These are [Claude Code](https://claude.ai/code) skills. To use them, copy the `skills/` directory into your Claude Code skills folder, then ask Claude to perform the task — it will invoke the right skill automatically.

---

## Available Skills

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
- Symlinks `dotfiles/zsh/zshrc` → `~/.zshrc`
- Symlinks `dotfiles/tmux/.tmux.conf` → `~/.tmux.conf`
- Symlinks `dotfiles/tmux/.auto_load` → `~/.tmux_auto_load`
- Adds `tx` and `tx_load` aliases to the managed zshrc

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
├── bootstrap.sh
├── dotfiles/
│   ├── tmux/
│   │   ├── .tmux.conf
│   │   └── .auto_load
│   └── zsh/
│       └── zshrc
└── skills/
    ├── wss-git-alias/
    │   ├── SKILL.md
    │   ├── git_alias.sh
    │   └── wss-git-alias.sh
    ├── wss-git-ssh/
    │   ├── SKILL.md
    │   └── wss-git-ssh.sh
    └── wss-tmux/
        ├── SKILL.md
        ├── config.sh
        └── wss-tmux.sh
```
