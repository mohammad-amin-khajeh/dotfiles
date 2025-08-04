#!/bin/sh

xrdb="xrdb"
xinitdir="/etc/X11/xinit"
xmodmap="xmodmap"

userresources="${XDG_CONFIG_HOME:-$HOME/.config/}/X11/.Xresources"
usermodmap="${XDG_CONFIG_HOME:-$HOME/.config/}/X11/.Xmodmap"
sysresources="$xinitdir/.Xresources"
sysmodmap="$xinitdir/.Xmodmap"

# merge in defaults and keymaps

if [ -f "$sysresources" ]; then
  if [ -x /usr/bin/cpp ]; then
    "$xrdb" -load "$sysresources"
  else
    "$xrdb" -nocpp -load "$sysresources"
  fi
fi

if [ -f "$sysmodmap" ]; then
  "$xmodmap" "$sysmodmap"
fi

if [ -f "$userresources" ]; then
  if [ -x /usr/bin/cpp ]; then
    "$xrdb" -load "$userresources"
  else
    "$xrdb" -nocpp -load "$userresources"
  fi
fi

if [ -f "$usermodmap" ]; then
  "$xmodmap" "$usermodmap"
fi

# start some nice programs

if [ -d "$xinitdir"/xinitrc.d ]; then
  for f in "$xinitdir/xinitrc.d"/?*.sh; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# redshift to make screen light easier on the eyes
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
# It changes depending on the connected devices
# But it's typically one of these
xinput set-prop 10 "libinput Accel Speed" 0.8 &
xinput set-prop 9 "libinput Accel Speed" 0.8 &
xinput set-prop 8 "libinput Accel Speed" 0.8 &

set -- "dunst" \
  "dwmblocks" \
  "nm-applet" \
  "picom" \
  "sxhkd" \
  "xhidecursor"

for program in "$@"; do
  if ! pidof -sx "$program" >/dev/null && command -v "$program" >/dev/null; then
    "$program" &
  fi
done

# Start a default tmux session in case it doesn't exist
"$HOME/.local/bin/launch_tmux.sh" &

exec dwm
