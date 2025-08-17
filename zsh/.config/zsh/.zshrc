# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# completions
zstyle ':plugin:ez-compinit' 'compstyle' 'ohmy'

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-~}/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch "${zsh_plugins}".txt

# Lazy-load antidote from its functions directory(Installed with yay).
fpath=(/usr/share/zsh-antidote/functions $fpath)
autoload -Uz antidote

# Generate a new static file whenever .zsh_plugins.txt is updated.
if [[ ! ${zsh_plugins}.zsh -nt ${zsh_plugins}.txt ]]; then
  antidote bundle <"${zsh_plugins}".txt >|"${zsh_plugins}".zsh
fi

# Source your static plugins file.
source "${zsh_plugins}".zsh

# Theme
[[ -f "$ZDOTDIR"/.p10k.zsh ]] && source "$ZDOTDIR"/.p10k.zsh

#history
export HISTFILE="${HOME}/.dotfiles/zsh/.config/zsh/.histfile"
export HISTSIZE=50000
export SAVEHIST=50000

#useful aliases
alias \
  c='clear' \
  cp='cp -ivp' \
  df='df -h' \
  du='du -h' \
  ffmpeg='ffmpeg -hide_banner' \
  ffmpeg='ffmpeg -hide_banner' \
  ffprobe='ffprobe -hide_banner' \
  free='free -h' \
  lg='lazygit' \
  ll='eza -l --icons -a --git' \
  ls='eza --icons -a --group-directories-first' \
  mkd='mkdir -pv' \
  mpvfs='mpv --player-operation-mode=pseudo-gui' \
  mpyt='mpv --ytdl-format=302+140/298+140/22/302+140/398+140/244+140' \
  mv='mv -iv' \
  n='nvim' \
  nfetch='fastfetch -c ~/.config/fastfetch/neofetch.jsonc' \
  open='xdg-open' \
  pac='sudo pacman' \
  pacins='sudo pacman -S --needed' \
  pacrem='sudo pacman -Rns' \
  pacup='sudo pacman -Syu' \
  rm='rm -vI' \
  rsync='rsync -vrPlu' \
  te='trash-empty' \
  tl='trash-list' \
  tmux='tmux -u' \
  tree='eza --tree -a --long --icons' \
  umnt='sudo umount' \
  wget='wget --no-hsts' \
  ytcut='yt-dlp --force-keyframes-at-cuts --download-sections' \
  ytdl='yt-dlp' \
  za='zathura'

# autoload -U promptinit; promptinit

#plugins and configurations
zle_highlight+=('paste:none')
zstyle ':completion:*:*:mpv:*'         file-sort modification
zstyle ':completion:*:*:nsxiv-rifle:*' file-sort modification
zstyle ':completion:*:*:n:*'           file-sort modification
zstyle ':completion:*:*:rm:*'          file-sort modification
zstyle ':completion:*:*:cpf:*'         file-sort modification
zstyle ':completion::complete:*' gain-privileges 1
setopt autocd
setopt sharehistory
setopt correctall
setopt menu_complete
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt hist_ignore_space
setopt inc_append_history
unsetopt nomatch

eval "$(zoxide init zsh)"


 # Edit the current command with default editor
bindkey "^x" kill-buffer

#binds
bindkey -v
export KEYTIMEOUT=1
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z

export WORDCHARS='~!#$%^&*,(){}[]<>?.+_\\|'
