#!/usr/bin/env bash

# bootstraps new arch installations
# Installs specified packages and applies changes I prefer

set -euo pipefail

install_yay() {
  if [ ! "$(command -v yay)" ]; then
    git clone https://aur.archlinux.org/packages/yay-bin
    cd yay-bin
    makepkg -si
  fi
}

read -rp "enter your password: " pass

install_packages() {
  local apps=(
    "calcurse"
    "cmus"
    "fcitx5-im"
    "fcitx5-mozc"
    "firefox"
    "mpv"
    "pcmanfm-gtk3"
    "qalculate-gtk"
    "qbittorrent"
    "telegram-desktop"
    "throne-bin"
    "tmux"
    "tor"
    "typst"
    "yazi"
    "zathura"
    "zola"
  )

  local editor=(
    "bash-language-server"
    "lua-language-server"
    "neovim"
    "pyright"
    "ruff"
    "shellcheck-bin"
    "shfmt"
    "stylua"
    "tinymist"
  )

  local fonts=(
    "awesome-terminal-fonts"
    "noto-fonts-cjk"
    "noto-fonts-emoji"
    "otf-font-awesome"
    "otf-ipafont"
    "ttf-cascadia-code-nerd"
    "ttf-cm-unicode"
    "ttf-firacode-nerd"
    "ttf-font-awesome"
    "ttf-jetbrains-mono-nerd"
    "ttf-joypixels"
    "ttf-ms-fonts"
    "ttf-opensans"
  )

  local libs_and_deps=(
    "imlib2"
    "libheif"
    "libnotify"
    "mac"
    "zathura-pdf-mupdf"
  )

  local shell=(
    "dash"
    "zsh"
    "zsh-antidote"
  )

  local theme=(
    "arc-gtk-theme"
    "lxappearance-gtk3"
    "papirus-icon-theme"
  )

  local tools=(
    "7zip"
    "aria2"
    "bat"
    "brightnessctl"
    "btop"
    "cuetools"
    "deno"
    "dunst"
    "dunst"
    "easytag"
    "entr"
    "eza"
    "fastfetch"
    "fd"
    "ffmpegthumbnailer"
    "fzf"
    "github-cli"
    "glow"
    "gparted"
    "gpaste"
    "hacksaw"
    "htop"
    "jq"
    "lazygit"
    "mpv-mpris"
    "network-manager-applet"
    "npm"
    "ouch"
    "pamixer"
    "pavucontrol"
    "picom"
    "playerctl"
    "pnpm"
    "python-pipx"
    "redshift"
    "ripgrep"
    "rofi"
    "rofimoji"
    "screenkey"
    "shntool"
    "shotgun"
    "silicon"
    "simple-mtpfs"
    "slock"
    "stow"
    "tealdeer"
    "termdown"
    "tesseract" "tesseract-data-eng"
    "tmux-plugin-manager"
    "trash-cli"
    "udisks2"
    "ueberzugpp"
    "unzip"
    "wget"
    "xdg-desktop-portal-termfilechooser-hunkyburrito-git"
    "zip"
    "zoxide"
  )

  local xorg=(
    "sxhkd"
    "xclip"
    "xcolor"
    "xdotool"
    "xorg-xinit"
    "xorg-xrandr"
    "xorg-xrdb"
    "xwallpaper"
  )

  yay -Syu --noconfirm --needed --sudoloop --removemake \
    "${apps[@]}" \
    "${editor[@]}" \
    "${fonts[@]}" \
    "${libs_and_deps[@]}" \
    "${shell[@]}" \
    "${theme[@]}" \
    "${tools[@]}" \
    "${xorg[@]}"

  pipx insall scdl
}

download_anki() {
  local path
  local url
  local file_name
  path="$HOME/Downloads"
  url="$(curl 'https://apps.ankiweb.net/' | grep -o 'https://\S*linux.*\.zst' | head -n1)"
  file_name="${url##*/}"

  if [ -f "$path/$file_name" ]; then
    echo "anki is already donwloaded."
    return 0
  fi

  wget -P "$path" "$url"
  echo "donwloaded anki."
}

install_yt_dlp_nightly() {
  local version
  local path

  path="/usr/local/bin"

  if [ -f "$path"/yt-dlp ]; then
    echo "yt-dlp nightly is already available."
    return 0
  fi

  version="$(curl https://github.com/yt-dlp/yt-dlp-nightly-builds/releases \
    | rg -i -o nightly\ [0-9].*[0-9] \
    | rev \
    | cut -d' ' -f 1 \
    | rev \
    | cut -d \< -f 1 \
    | head -n 1)"

  echo "$pass" \
    | sudo -S wget -P "$path" https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/download/"$version"/yt-dlp

  echo "$pass" \
    | sudo -S chmod a+x "$path"/yt-dlp

  echo "yt-dlp nightly downloaded."
}

yt_dlp_completions() {
  local comp_path
  comp_path="/usr/share/zsh/site-functions"

  if [ -f "$comp_path/_yt-dlp" ]; then
    echo "completion already available."
    return 0
  fi

  wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.tar.gz
  tar -xzvf yt-dlp.tar.gz yt-dlp/completions/zsh/_yt-dlp
  echo "$pass" | sudo -S mv yt-dlp/completions/zsh/_yt-dlp "$comp_path/_yt-dlp"
  rm -rf yt-dlp yt-dlp.tar.gz

  echo "added zsh completions for yt-dlp."
}

remove_motherboard_beep_sound() {
  printf 'blacklist pcspkr\nblacklist snd_pcsp' | sudo tee /etc/modprobe.d/nobeep.conf
}

pulseaudio_modules() {
  echo 'load-module module-switch-on-connect' | sudo tee /etc/pulse/default.pa
}

decrease_swappiness() {
  echo 'vm.swappiness = 10' | sudo tee /etc/sysctl.d/99-swappiness.conf
}

journald_set_max_space() {
  echo "$pass" | sudo -S sed -i 's/#SystemMaxUse=/SystemMaxUse=50M/' /etc/systemd/journald.conf
}

install_suckless_tools() {
  local git_urls=("dwm-flexipatch" "st-flexipatch" "dwmblocks-async" "nsxiv")
  local tools=("dwm" "st" "dwmblocks-async" "nsxiv")

  for i in $(seq 0 4); do
    local current_tool="${tools[i]}"
    local current_url="${git_urls[i]}"

    if [ -d "$HOME/.local/src/$current_tool" ]; then
      continue
    fi

    git clone https://github.com/mohammad-amin-khajeh/"$current_url" "$HOME/.local/src/$current_tool"
    cd "$HOME/.local/src/$current_tool"
    echo "$pass" | sudo -S make install
  done
}

set_grub_options() {
  if echo "$pass" | sudo -S sed -i "s/GRUB_DEFAULT='0'/GRUB_DEFAULT='saved'/" /etc/default/grub; then echo "'GRUB_DEFAULT' set to 'saved'."; fi
  if echo "$pass" | sudo -S sed -i "s/#GRUB_SAVEDEFAULT=true/GRUB_SAVEDEFAULT=true/" /etc/default/grub; then echo "'GRUB_SAVEDEFAULT' set to 'true'."; fi
  if echo "$pass" | sudo -S sed -i "s/GRUB_DISABLE_SUBMENU='false'/GRUB_DISABLE_SUBMENU='true'/" /etc/default/grub; then echo "'GRUB_DISABLE_SUBMENU' set to 'true'."; fi
}

configure_touchpad() {
  echo 'Section "InputClass"
Identifier "libinput touchpad catchall"
MatchIsTouchpad "on"
MatchDevicePath "/dev/input/event*"
Driver "libinput"
Option "Tapping" "on"
EndSection' | sudo tee /etc/X11/xorg.conf.d/30-touchpad.conf
}

symlink_sh_to_dash() {
  [ "$(command -v dash)" ] && echo "$pass" | sudo -S ln -sfT dash /usr/bin/sh
}

hook_for_dash_to_sh() {
  echo '[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Target = bash

[Action]
Description = Re-pointing /bin/sh symlink to dash...
When = PostTransaction
Exec = /usr/bin/ln -sfT dash /usr/bin/sh
Depends = dash' | sudo tee /usr/share/libalpm/hooks/dash-symlink.hook
}

install_yay
install_packages
download_anki
install_yt_dlp_nightly
yt_dlp_completions
remove_motherboard_beep_sound && echo "removed motherboard beep sound."
pulseaudio_modules && echo "set pulseaudio modules."
decrease_swappiness && echo "decreased swappiness."
journald_set_max_space && echo "set max journald size to 50MB."
install_suckless_tools
set_grub_options
configure_touchpad && echo "touchpad configured."
symlink_sh_to_dash && echo "symlinked sh to dash."
hook_for_dash_to_sh && echo "dash->sh hook added."
