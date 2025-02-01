#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(find ~/Documents/code ~/Documents/konkour ~/Documents/code/* \
    ~/Documents/code/*/projects ~/Documents/blog ~/Documents/code/frontend/tailwind \
    -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)

tmux neww -c "$selected" -n "$selected_name" -S
