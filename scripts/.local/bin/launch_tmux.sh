#!/usr/bin/env bash

if pgrep tmux:\ server &>/dev/null; then
  tmux attach-session
else
  "$XDG_CONFIG_HOME"/tmux/login_session.sh
fi
