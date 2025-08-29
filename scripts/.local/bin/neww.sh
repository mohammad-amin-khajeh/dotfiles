#!/usr/bin/env sh

if [ $# -eq 1 ]; then
  selected=$1
else
  selected=$(find -L \
    ~/Documents/code ~/Documents/code/* \
    ~/.config ~/.local ~/.local/src ~/Documents ~/Documents/blog ~/Documents/code/*/projects \
    -maxdepth 1 -type d | fzf)
fi

if [ -z "$selected" ]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)

tmux neww -c "$selected" -n "$selected_name" -S
