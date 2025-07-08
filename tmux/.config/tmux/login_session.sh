#!/usr/bin/env bash

# Create a new tmux session named 'code' with the first window named 'code'
tmux new-session -d -s code -n code -c ~/Documents/code/python/leetcode/

# Set layout to main-horizontal in the first window
tmux select-layout -t code:code main-horizontal

# Create second window named 'cmus'
tmux new-window -t code: -n cmus
tmux select-layout -t code:cmus main-horizontal

# In the cmus window, start 'cmus' command in the first pane
tmux send-keys -t code:cmus "cmus" C-m

# Create third window named 'timer'
tmux new-window -t code: -n timer
tmux select-layout -t code:timer main-horizontal

# Type the 'study 30m' command in the first pane of the timer window without pressing enter automatically (simulate sleep then send keys without Enter)
sleep 0.2
tmux send-keys -t code:timer "study 30m"

# Finally, attach to the session and focus on the first window
tmux select-window -t code:code
tmux attach-session -t code
