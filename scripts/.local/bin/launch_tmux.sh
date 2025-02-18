#!/usr/bin/env bash

# path_to_tmux_sessionizer=".local/bin/tmux-sessionizer"
tmuxp_layout="leetcode"
if pgrep tmux &>/dev/null; then
  tmux attach
else
  tmuxp load "$tmuxp_layout"
fi
