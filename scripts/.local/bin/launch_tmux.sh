#!/usr/bin/env sh

if pgrep tmux:\ server >/dev/null 2>&1; then
  tmux attach-session
else
  exec "$XDG_CONFIG_HOME"/tmux/leetcode_session.sh
fi
