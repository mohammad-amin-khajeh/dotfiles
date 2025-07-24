if [ "$DISPLAY" = "" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi
