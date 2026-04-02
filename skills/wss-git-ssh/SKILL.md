---
name: wss-git-ssh
description: Use this skill when the user wants to configure SSH for a GitHub account, add a GitHub SSH key, or set up git SSH access.
version: 1.0.0
---

# wss-git-ssh

Configures SSH for a GitHub account by adding a host entry to `~/.ssh/config`.

## When This Skill Applies

- User wants to set up SSH for GitHub
- User gets `Permission denied (publickey)` on git push/pull
- User wants to add a new GitHub account's SSH key

## Entry Point

```bash
bash skills/wss-git-ssh/wss-git-ssh.sh
```

## What It Does

1. Prompts for GitHub username and SSH key path
2. Adds a `Host github.com` entry to `~/.ssh/config` (idempotent)
3. Tests the connection with `ssh -T git@github.com`

## SSH Config Added

```
# github <username>
Host github.com
  HostName github.com
  User git
  IdentityFile <ssh_key>
  AddKeysToAgent yes
  UseKeychain yes
```
