#!/usr/bin/env sh

[ -d "$HOME/Documents/phone" ] || mkdir ~/Documents/phone

chosen=$(printf "mount\nunmount\n" | rofi -dmenu)

case "$chosen" in
mount)
  fusermount -u ~/Documents/phone
  simple-mtpfs ~/Documents/phone
  ;;
unmount) fusermount -u "$HOME/Documents/phone" ;;
esac
