#!/usr/bin/env bash

mode=$(printf "tv\ninternal\n" | rofi -dmenu -p "select the mode please:")
case "$mode" in
tv)
  xrandr --output HDMI-1 --mode 1920x1080 --output eDP-1 --off ||
    xrandr --addmode HDMI-1 1920x1080 &&
    xrandr --output HDMI-1 --mode 1920x1080 --output eDP-1 --off
  pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:hdmi-stereo+input:analog-stereo
  ;;
internal)
  xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --off
  pactl set-card-profile alsa_card.pci-0000_00_1f.3 output:analog-stereo+input:analog-stereo
  ;;
*)
  exit 1
  ;;
esac
