#!/usr/bin/env sh

sesh_name="study"

if tmux has-session -t "$sesh_name" 2> /dev/null; then
  if [ -z "$TMUX" ]; then
    exec tmux attach-session -t "$sesh_name"
  else
    echo "you're already in tmux."
  fi
  exit 0
fi

tmux new-session -d -s "$sesh_name" -n timer "sh"

# fix the prompt glitching problem
sleep 0.1
tmux send-keys -t "$sesh_name":timer "study "

tmux select-window -t "$sesh_name":timer

# Attach or switch
if [ -z "$TMUX" ]; then tmux attach-session -t "$sesh_name"; else
  tmux switch-client -t "$sesh_name":timer
fi
