#!/usr/bin/env bash
set -euo pipefail

wallpath="${HOME}/Pictures/wallpapers"
if [ $# -eq 0 ]; then
  cd "$wallpath"
  wall="$wallpath/$(fd -e png -e jpg -e jpeg | rofi -dmenu -i -p 'select wallpaper:')"
else
  wall="$1"
fi
xwallpaper --zoom "$wall"
echo -n "$wall" >"$XDG_CACHE_HOME"/wallpaper
# wal -i "$wall"

Xresources_font_conf="Xft.antialias: 1
Xft.autohint: 0
Xft.dpi: 96
Xft.hinting: 1
Xft.hintstyle: hintslight
Xft.lcdfilter: lcddefault
Xft.rgba: none"

grep -q "$Xresources_font_conf" ~/.cache/wal/colors.Xresources || printf '\n%s' "$Xresources_font_conf" >>~/.cache/wal/colors.Xresources

# case "$XDG_SESSION_DESKTOP" in
#
# i3)
# 	grep 'xargs --arg-file=.cache/wal/wal -d $ xwallpaper' ~/.config/i3/config >/dev/null ||
# 		echo 'xargs --arg-file=.cache/wal/wal -d $ xwallpaper --zoom' >>~/.config/i3/config
# 	;;
# dwm)
# 	dwm_normbgcolor="$(rg color0 -m1 ~/.Xresources | sed "s/^.*:/dwm.normbgcolor:/")"
# 	dwm_normbordercolor="dwm.normbordercolor: \#ff0000"
# 	dwm_normfgcolor="$(rg color2 -m1 ~/.Xresources | sed "s/^.*:/dwm.normfgcolor:/")"
# 	dwm_selbgcolor="$(rg color5 -m1 ~/.Xresources | sed "s/^.*:/dwm.selbgcolor:/")"
# 	dwm_selbordercolor="dwm.selbordercolor: \#00ff00"
# 	dwm_selfgcolor="$(rg color9 -m1 ~/.Xresources | sed "s/^.*:/dwm.selfgcolor:/")"
# 	dwm_selfloatcolor="$(rg color2 -m1 ~/.Xresources | sed "s/^.*:/dwm.selfloatcolor:/")"
# 	dwm_normfloatcolor="$(rg color2 -m1 ~/.Xresources | sed "s/^.*:/dwm.normfloatcolor:/")"
# 	dwm_tagsnormbgcolor="$(rg color0 -m1 ~/.Xresources | sed "s/^.*:/dwm.tagsnormbgcolor:/")"
# 	dwm_tagsnormbordercolor="$(rg color3 -m1 ~/.Xresources | sed "s/^.*:/dwm.tagsnormbordercolor:/")"
# 	dwm_tagsnormfgcolor="$(rg color2 -m1 ~/.Xresources | sed "s/^.*:/dwm.tagsnormfgcolor:/")"
# 	dwm_tagsselbgcolor="$(rg color2 -m1 ~/.Xresources | sed "s/^.*:/dwm.tagsselbgcolor:/")"
# 	dwm_tagsselbordercolor="$(rg color5 -m1 ~/.Xresources | sed "s/^.*:/dwm.tagsselbordercolor:/")"
# 	dwm_tagsselfgcolor="$(rg color0 -m1 ~/.Xresources | sed "s/^.*:/dwm.tagsselfgcolor:/")"
# 	dwm_titleselbgcolor="$(rg color2 -m1 ~/.Xresources | sed "s/^.*:/dwm.titleselbgcolor:/")"
# 	dwm_titleselfgcolor="$(rg color0 -m1 ~/.Xresources | sed "s/^.*:/dwm.titleselfgcolor:/")"
#
# 	echo "! dwm stuff
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
# $dwm_titleselfgcolor" >>~/.Xresources
#
# 	xrdb -load ~/.Xresources && xdotool key Super+Shift+F5
# 	;;
# *)
# 	echo "the wm is not supported, aborting..."
# 	return 1
# 	;;
# esac
