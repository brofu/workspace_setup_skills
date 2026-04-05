#!/usr/bin/env bash
# Oh-My-Zsh + Powerlevel10k zshrc block
# Sourced by the managed zshrc after this skill runs.

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    z
    docker
    kubectl
)

source "$ZSH/oh-my-zsh.sh"

# Powerlevel10k instant prompt (must be near top of zshrc)
# Enable with: p10k configure
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
