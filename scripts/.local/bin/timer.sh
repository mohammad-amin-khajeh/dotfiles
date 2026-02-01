#!/bin/sh

# === CONFIG ===
TIMER_FILE="/tmp/rofi_countdown_pid"
START_TIME_FILE="/tmp/rofi_countdown_start"

ROFI_CMD='rofi -dmenu -i -p Timer -kb-accept-entry !Return -format i'

# === Generate intervals starting from 1:30 (90s) in 30-second steps ===
generate_intervals() {
  start=90 # seconds
  steps=20
  i=0

  while [ "$i" -lt "$steps" ]; do
    sec=$((start + i * 30))
    printf '%02d:%02d\n' $((sec / 60)) $((sec % 60))
    i=$((i + 1))
  done
}

# === Kill running timer (used for cancel AND auto-replace) ===
cancel_running_timer() {
  if [ -f "$TIMER_FILE" ] && [ -f "$START_TIME_FILE" ]; then
    pid=$(cat "$TIMER_FILE")
    start=$(cat "$START_TIME_FILE")

    if kill "$pid" 2> /dev/null; then
      elapsed=$(($(date +%s) - start))
      min=$((elapsed / 60))
      sec=$((elapsed % 60))

      notify-send "⏹ Timer canceled" \
        "Elapsed: ${min}m ${sec}s" -t 1000

      rm -f "$TIMER_FILE" "$START_TIME_FILE"
      return 0
    fi
  fi

  return 1
}

# === Manual kill mode ===
case "$1" in
kill)
  if cancel_running_timer; then
    exit 0
  else
    notify-send "⚠ No running timer" "Nothing to cancel." -t 1000
    exit 1
  fi
  ;;
esac

# === Show rofi menu ===
choice_index=$(generate_intervals | sh -c "$ROFI_CMD")
[ -z "$choice_index" ] && exit 0

# === If a timer is already running, replace it ===
cancel_running_timer > /dev/null 2>&1

# === Resolve chosen interval ===
choice=$(generate_intervals | sed -n "$((choice_index + 1))p") || exit 0

minutes=$(printf '%s\n' "$choice" | cut -d: -f1)
seconds=$(printf '%s\n' "$choice" | cut -d: -f2)

# 10# avoids any accidental octal interpretation
minutes=$(printf '%d\n' "$minutes")
seconds=$(printf '%d\n' "$seconds")
total_seconds=$((minutes * 60 + seconds))

# === Start new timer ===
(
  sleep "$total_seconds"
  notify-send "⏱ Time's up!" "${choice} elapsed!"
) &

pid=$!
date +%s > "$START_TIME_FILE"
echo "$pid" > "$TIMER_FILE"

notify-send "▶ Timer started" "Counting down: $choice" -t 1000
