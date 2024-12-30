#!/usr/bin/env sh

if ! pgrep tor >/dev/null; then
  systemctl start tor.service && dunstify "connected✅" -t 1000 || dunstify "connection failed❌" -t 1000
else
  systemctl stop tor.service && dunstify "disconnected✅" -t 1000 || dunstify "failed to disconnect❌" -t 1000
fi
