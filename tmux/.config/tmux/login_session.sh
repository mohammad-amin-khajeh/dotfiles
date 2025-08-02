#!/usr/bin/env dash

# Create a new tmux session named 'code' with the first window named 'code'
tmux new-session -d -s code -n code -c ~/Documents/code/python/leetcode/

# Create second window named 'cmus' and open cmus in it
tmux new-window -t code: -n cmus "cmus"

# Create third window named 'timer'
tmux new-window -t code: -n timer "dash"

# Type the 'study 30m' command in the first pane of the timer window without pressing enter automatically (simulate sleep then send keys without Enter)
sleep 0.2
tmux send-keys -t code:timer "study 30m"

# Finally, attach to the session and focus on the first window
tmux select-window -t code:code
tmux attach-session -t code
