# xdg base directory specification
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"

# default programs and other quality of life stuff
export BROWSER="firefox"
export CARGO_HOME="$HOME/.local/cargo"
export EDITOR="nvim"
export GLFW_IM_MODULE="ibus"
export GTK_IM_MODULE="fcitx"
export MANPAGER="nvim +Man!"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PATH="${PATH}:$HOME/.local/bin:$HOME/.local/bin/fred:$CARGO_HOME/bin:$XDG_DATA_HOME/pnpm"
export QT_IM_MODULE="fcitx"
export RUSTUP_HOME="$HOME/.local/rustup"
export term="st"
export VISUAL="nvim"
export XMODIFIERS=@im="fcitx"
export ZDOTDIR="$HOME/.config/zsh"

# source fzf colors
. "$XDG_CONFIG_HOME/fzf/tokyonight_night.sh"

if [ "$DISPLAY" = "" ] && [ "$XDG_VTNR" = 1 ]; then
  exec startx "$XDG_CONFIG_HOME/X11/.xinitrc"
fi
