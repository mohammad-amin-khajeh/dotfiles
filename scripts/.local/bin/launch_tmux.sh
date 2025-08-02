#!/usr/bin/env dash

if pgrep tmux:\ server >/dev/null 2>&1; then
  tmux attach-session
else
  exec "$XDG_CONFIG_HOME"/tmux/login_session.sh
fi
