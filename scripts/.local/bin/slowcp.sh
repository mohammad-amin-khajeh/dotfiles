#!/usr/bin/env bash

dest="${HOME}/Documents/phone/Music"
copy_with_delay() {
  dir="$(basename "$1")"
  [ -d "$dest/$dir" ] || mkdir -pv "$dest/$dir"
  for item in "$1"/*; do
    if [ -d "$item" ]; then
      copy_with_delay "$item"
    elif [ -f "$item" ]; then
      cp -pv "$item" "$dest/$dir"
      sleep 1
    fi
  done
}

for source in "$@"; do
  copy_with_delay "$source"
done
