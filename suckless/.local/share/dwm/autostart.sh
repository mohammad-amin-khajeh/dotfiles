#!/usr/bin/env bash

redshift -x
redshift -O 2800k &
xwallpaper --zoom "$(\find Pictures/wallpapers | shuf -n1)" &
setxkbmap -model pc104 -layout us,ir -variant ,winkeys -option grp:alt_shift_toggle -option "caps:swapescape" &
xset r rate 200 32 &
xset s 180 180 &
xinput set-prop 10 "libinput Accel Speed" 0.8 &
xinput set-prop 9 "libinput Accel Speed" 0.8 &
xinput set-prop 8 "libinput Accel Speed" 0.8 &
pgrep copyq || copyq &
pgrep nm-applet || nm-applet &
pgrep dunst || dunst &
pgrep sxhkd || sxhkd &
pgrep picom || picom --daemon &
killall dwmblocks
zsh -c dwmblocks &

xdotool key super+c
