#!/usr/bin/env bash

set -euo pipefail

reminder_file="$HOME/Documents/reminders.txt"
reminder_text="$(rofi -dmenu -p "what is the reminder?")"
printf "$reminder_text\n\n" >>"$reminder_file"
