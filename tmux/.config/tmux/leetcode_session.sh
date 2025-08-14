#!/usr/bin/env sh

sesh_name="code"

if tmux has-session -t "$sesh_name">/dev/null; then
  tmux attach-session -t "$sesh_name"
  exit 0
fi

# Create a new tmux session named 'code' with the first window named 'leetcode'
tmux new-session -d -s "$sesh_name" -n leetcode -c ~/Documents/code/python/leetcode/

# Create second window named 'cmus' and open cmus in it
tmux new-window -t "$sesh_name": -n cmus "cmus"

# Create third window named 'timer'
tmux new-window -t "$sesh_name": -n timer "sh"

# Type the 'study 30m' command in the first pane of the timer window without pressing enter automatically (simulate sleep then send keys without Enter)
sleep 0.2
tmux send-keys -t "$sesh_name":timer "study 30m"

# Finally, attach to the session and focus on the first window
tmux select-window -t "$sesh_name":leetcode
tmux attach-session -t "$sesh_name"
