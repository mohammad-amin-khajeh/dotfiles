#!/usr/bin/env bash

# redshift to make screen light easier on the eyes
redshift -x
redshift -O 2000k &

########################################
######### ENABLE ONE OF THEM ###########
# set a random wallpaper
# xwallpaper --zoom "$(\find Pictures/wallpapers | shuf -n1)" &

# set the last wallpaper
xargs --arg-file="$XDG_CACHE_HOME"/wallpaper -d $ xwallpaper --zoom &
########################################

# Enable Persian and English layouts
# Along with swapping escape and caps-lock
setxkbmap -model pc104 -layout us,ir -variant ,winkeys -option grp:alt_shift_toggle -option "caps:swapescape" &

# Set key repetition delay and rate
xset r rate 200 32 &

# Set automatic turn off of the monitor to 3 minutes
xset s 180 180 &

# Make trackpad faster
xinput set-prop 10 "libinput Accel Speed" 0.8 &
xinput set-prop 9 "libinput Accel Speed" 0.8 &
xinput set-prop 8 "libinput Accel Speed" 0.8 &

# Launch startup programs
pgrep copyq || copyq &
pgrep nm-applet || nm-applet &
pgrep dunst || dunst &
pgrep sxhkd || sxhkd &
pgrep picom || picom --daemon &

# HACK: Fix dwmblocks not starting with autostart patch
# by executing it through zsh
sleep 0.5
killall dwmblocks
zsh -c dwmblocks &

# Switch to tmux tag(tag 5)
xdotool key super+c
sleep 0.2

# open calcurse
st -e calcurse
