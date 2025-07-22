#history
export HISTFILE="${HOME}/.dotfiles/zsh/.config/zsh/.histfile"
export HISTSIZE=50000
export SAVEHIST=50000

# xdg base directory specification
export CUDA_CACHE_PATH="$XDG_CACHE_HOME/nv"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export GTK2_RC_FILES="$XDG_CONFIG_HOME/gtk-2.0/gtkrc"
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/pythonrc"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# default programs and other quality of life stuff
export BROWSER="firefox"
export CARGO_HOME="$HOME/.local/cargo"
export EDITOR="nvim"
export GLFW_IM_MODULE="ibus"
export GTK_IM_MODULE="fcitx"
export MANPAGER="nvim +Man!"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/node_repl_history"
export PATH="${PATH}:$HOME/.local/bin:$HOME/.local/bin/fred:$CARGO_HOME/bin:$XDG_CONFIG_HOME/composer/vendor/bin"
export QT_IM_MODULE="fcitx"
export RUSTUP_HOME="$HOME/.local/rustup"
export SHELL="/bin/zsh"
export term="st"
export VISUAL="nvim"
export XMODIFIERS=@im="fcitx"
export ZDOTDIR="$HOME/.config/zsh"

# pnpm
export PNPM_HOME="/home/mmd/.local/share/pnpm"
case ":$PATH:" in
*":$PNPM_HOME:"*) ;;
*) export PATH="$PNPM_HOME:$PATH" ;;
esac

# source fzf colors
source "$XDG_CONFIG_HOME/fzf/tokyonight_night.sh"
