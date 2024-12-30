#!/usr/bin/env bash

set -euo pipefail

reminder_file="$HOME/Documents/reminders.txt"
reminder_text="$(rofi -dmenu -p "what's is the reminder?")"
printf "$reminder_text\n\n" >> "$reminder_file"
