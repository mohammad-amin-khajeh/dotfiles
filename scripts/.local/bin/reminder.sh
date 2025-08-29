#!/usr/bin/env sh

reminder_file="$HOME/Documents/reminders.txt"
reminder_text="$(rofi -dmenu -p "what is the reminder?")"
printf "%s\n\n" "$reminder_text" >> "$reminder_file"
