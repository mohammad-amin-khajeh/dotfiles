#!/usr/bin/env sh

todo_path="$XDG_DATA_HOME/calcurse/todo"
todo_text="$(rofi -dmenu -p "what is the TODO?")"
todo_prio="$(rofi -dmenu -p "what is the priority? (leave empty for 0)")"
todo_item="[${todo_prio:-0}] $todo_text"

echo "temp" >> "$todo_path"
sed -i -e "1i $todo_item" -e '$ d' "$todo_path"
