#!/usr/bin/env sh

session_name="study_session.sh"

if pgrep tmux:\ server > /dev/null 2>&1; then
  tmux attach-session
else
  exec "$XDG_CONFIG_HOME"/tmux/"$session_name"
fi
