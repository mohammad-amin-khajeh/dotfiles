#!/usr/bin/env bash

path_to_tmux_sessionizer=".local/bin/tmux-sessionizer"
if pgrep tmux &>/dev/null; then
  tmux attach
else
  "$path_to_tmux_sessionizer"
fi
