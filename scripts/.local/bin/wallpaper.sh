#!/usr/bin/env sh

# set the wallpaper and run pywal on it at the same time
# uncomment the lines below to make pywal themeing work
# otherwise just leave it as is to only set the wallpaper

wallpath="${HOME}/Pictures/wallpapers"
xresources_path="${XDG_CONFIG_HOME:-$HOME/.config}/X11/.Xresources"

if [ $# -eq 0 ]; then
  cd "$wallpath" || exit
  wall="$wallpath/$(fd -e png -e jpg -e jpeg | rofi -dmenu -i -p 'select wallpaper:')"
else
  wall="$1"
fi
xwallpaper --zoom "$wall"
printf "%s" "$wall" > "$XDG_CACHE_HOME"/wallpaper

Xresources_font_conf="Xft.antialias: 1
Xft.autohint: 0
Xft.dpi: 96
Xft.hinting: 1
Xft.hintstyle: hintslight
Xft.lcdfilter: lcddefault
Xft.rgba: none"

grep -q "$Xresources_font_conf" "$xresources_path" || printf '\n%s' "$Xresources_font_conf" >> "$xresources_path"

# wal -i "$wall"

# dwm_normbgcolor="$(rg color0 -m1 "$xresources_path" | sed "s/^.*:/dwm.normbgcolor:/")"
# dwm_normbordercolor="dwm.normbordercolor: \#ff0000"
# dwm_normfgcolor="$(rg color2 -m1 "$xresources_path" | sed "s/^.*:/dwm.normfgcolor:/")"
# dwm_selbgcolor="$(rg color5 -m1 "$xresources_path" | sed "s/^.*:/dwm.selbgcolor:/")"
# dwm_selbordercolor="dwm.selbordercolor: \#00ff00"
# dwm_selfgcolor="$(rg color9 -m1 "$xresources_path" | sed "s/^.*:/dwm.selfgcolor:/")"
# dwm_selfloatcolor="$(rg color2 -m1 "$xresources_path" | sed "s/^.*:/dwm.selfloatcolor:/")"
# dwm_normfloatcolor="$(rg color2 -m1 "$xresources_path" | sed "s/^.*:/dwm.normfloatcolor:/")"
# dwm_tagsnormbgcolor="$(rg color0 -m1 "$xresources_path" | sed "s/^.*:/dwm.tagsnormbgcolor:/")"
# dwm_tagsnormbordercolor="$(rg color3 -m1 "$xresources_path" | sed "s/^.*:/dwm.tagsnormbordercolor:/")"
# dwm_tagsnormfgcolor="$(rg color2 -m1 "$xresources_path" | sed "s/^.*:/dwm.tagsnormfgcolor:/")"
# dwm_tagsselbgcolor="$(rg color2 -m1 "$xresources_path" | sed "s/^.*:/dwm.tagsselbgcolor:/")"
# dwm_tagsselbordercolor="$(rg color5 -m1 "$xresources_path" | sed "s/^.*:/dwm.tagsselbordercolor:/")"
# dwm_tagsselfgcolor="$(rg color0 -m1 "$xresources_path" | sed "s/^.*:/dwm.tagsselfgcolor:/")"
# dwm_titleselbgcolor="$(rg color2 -m1 "$xresources_path" | sed "s/^.*:/dwm.titleselbgcolor:/")"
# dwm_titleselfgcolor="$(rg color0 -m1 "$xresources_path" | sed "s/^.*:/dwm.titleselfgcolor:/")"
#
# echo "! dwm stuff
# $dwm_normbgcolor
# $dwm_normbordercolor
# $dwm_normfgcolor
# $dwm_normfloatcolor
# $dwm_selbgcolor
# $dwm_selbordercolor
# $dwm_selfgcolor
# $dwm_selfloatcolor
# $dwm_tagsnormbgcolor
# $dwm_tagsnormbordercolor
# $dwm_tagsnormfgcolor
# $dwm_tagsselbgcolor
# $dwm_tagsselbordercolor
# $dwm_tagsselfgcolor
# $dwm_titleselbgcolor
# $dwm_titleselfgcolor" >>"$xresources_path"

# xrdb -load "$xresources_path" && xdotool key Super+Shift+F5
