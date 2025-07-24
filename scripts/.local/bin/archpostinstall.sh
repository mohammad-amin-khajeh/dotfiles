#!/usr/bin/env bash

if [ ! "$(yay -h)" ] &>/dev/null; then
  git clone https://aur.archlinux.org/packages/yay-bin
  cd yay-bin
  makepkg -si
fi

set -euo pipefail

read -rp "enter your password: " pass
yay -Syu --noconfirm --needed --sudoloop --removemake \
  7zip \
  arc-gtk-theme \
  aria2 \
  awesome-terminal-fonts \
  bat \
  brightnessctl \
  btop \
  calcurse \
  cmus \
  copyq \
  cuetools \
  deno \
  dunst \
  easytag \
  entr \
  eza \
  fastfetch \
  fcitx5-im \
  fcitx5-mozc \
  fd \
  ffmpegthumbnailer \
  fzf \
  github-cli \
  glow \
  gparted \
  hacksaw \
  htop \
  imlib2 \
  jq \
  lazygit \
  libheif \
  libnotify \
  luarocks \
  lxappearance-gtk3 \
  mac \
  maven \
  mpv \
  mpv-mpris \
  nekoray-mahdi-zarei-bin \
  neovim \
  network-manager-applet \
  noto-fonts-cjk \
  noto-fonts-emoji \
  npm \
  otf-font-awesome \
  otf-ipafont \
  ouch \
  pamixer \
  papirus-icon-theme \
  pavucontrol \
  pcmanfm-gtk3 \
  picom \
  playerctl \
  pnpm \
  python-pipx \
  qalculate-gtk \
  qbittorrent \
  redshift \
  ripgrep \
  rofi \
  rofimoji \
  screenkey \
  shntool \
  shotgun \
  silicon \
  simple-mtpfs \
  slock \
  stow \
  sxhkd \
  tailwindcss-bin \
  tealdeer \
  telegram-desktop \
  termdown \
  tesseract-data-eng \
  tinymist \
  tmux \
  tmux-plugin-manager \
  tor \
  trash-cli \
  ttf-cascadia-code-nerd \
  ttf-cm-unicode \
  ttf-font-awesome \
  ttf-joypixels \
  ttf-ms-fonts \
  ttf-opensans \
  typescript \
  typst \
  udisks2 \
  ueberzugpp \
  unzip \
  wget \
  xclip \
  xcolor \
  xdg-desktop-portal-termfilechooser-hunkyburrito-git \
  xdotool \
  xorg-xinit \
  xorg-xrandr \
  xorg-xrdb \
  xwallpaper \
  yazi \
  zathura \
  zathura-cb \
  zathura-pdf-mupdf \
  zip \
  zola \
  zoxide \
  zsh \
  zsh-antidote

# autotiling \
# python-i3ipc \
# i3-back-bin \
# i3-wm \
# i3blocks \

# # Download anki
[ ! -f "$HOME/Downloads/anki-25.02.5-linux-qt6.tar.zst" ] && wget https://github.com/ankitects/anki/releases/download/25.02.5/anki-25.02.5-linux-qt6.tar.zst

# install yt-dlp nightly
ver="$(curl https://github.com/yt-dlp/yt-dlp-nightly-builds/releases | rg -i -o nightly\ [0-9].*[0-9] | rev | cut -d' ' -f 1 | rev | cut -d \< -f 1 | head -n 1)"
echo "$pass" | sudo -S aria2c -d /usr/local/bin -o yt-dlp https://github.com/yt-dlp/yt-dlp-nightly-builds/releases/download/"$ver"/yt-dlp
echo "$pass" | sudo -S chmod a+x /usr/local/bin/yt-dlp

# add completions for yt-dlp on zsh
aria2c https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp.tar.gz
tar -xzvf yt-dlp.tar.gz yt-dlp/completions/zsh/_yt-dlp
echo "$pass" | sudo -S mv yt-dlp/completions/zsh/_yt-dlp /usr/share/zsh/site-functions/
rm -rf yt-dlp yt-dlp.tar.gz

# Install scdl
pipx insall scdl

# # install phantomjs
# aria2c 'https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-2.1.1-linux-i686.tar.bz2'
# echo "$pass" | sudo -S mv phantomjs-2.1.1-linux-x86_64/bin/phantomjs /usr/local/bin/
# rm -rf {phantomjs-2.1.1-linux-x86_64.tar.bz2,phantomjs-2.1.1-linux-x86_64}

# echo 'options snd_hda_intel power_save=0' | sudo tee /etc/modprobe.d/audio_disable_powersave.conf

# disable the annoying motherboard beep sound.
# works on older PCs
echo 'blacklist pcspkr
blacklist snd_pcsp' | sudo tee /etc/modprobe.d/nobeep.conf

# enable automatic audio stream switching
echo 'load-module module-switch-on-connect' | sudo tee /etc/pulse/default.pa

# bypass polkit password prompt
echo '/* Allow members of the wheel group to execute any actions
* without password authentication, similar to "sudo NOPASSWD:"
*/
polkit.addRule(function(action, subject) {
if (subject.isInGroup("wheel")) {
  return polkit.Result.YES;
}
});' | sudo tee /etc/polkit-1/rules.d/49-nopasswd_global.rules

# decrease swappiness
echo 'vm.swappiness = 10' | sudo tee -a /etc/sysctl.d/99-swappiness.conf

# make zsh the default shell
echo '/sbin/zsh
zsh' | sudo tee -a /etc/shells
chsh "$USER" -s "$(which zsh)"

# fix journal taking all the space
echo "$pass" | sudo -S sed -i 's/#SystemMaxUse=/SystemMaxUse=50M/' /etc/systemd/journald.conf

# install suckless software
install_suckless() {
  if [ ! -d "$HOME/.local/src/${1}" ]; then
    git clone https://github.com/mohammad-amin-khajeh/"${2}" "$HOME/.local/src/${1}"
  fi
  cd "$HOME/.local/src/${1}"
  echo "$pass" | sudo -S make install
}

install_suckless dwm dwm-flexipatch
install_suckless st st-flexipatch
install_suckless dwmblocks-async dwmblocks-async
install_suckless nsxiv nsxiv

# # add rust completions if needed
# [ -f /usr/share/zsh/site-functions/_rustup ] || rustup completions zsh rustup | sudo tee /usr/share/zsh/site-functions/_rustup
# [ -f /usr/share/zsh/site-functions/_cargo ] || rustup completions zsh cargo | sudo tee /usr/share/zsh/site-functions/_cargo

# setting grub options
if echo "$pass" | sudo -S sed -i "s/GRUB_DEFAULT='0'/GRUB_DEFAULT='saved'/" /etc/default/grub; then echo "'GRUB_DEFAULT' set to 'saved'."; fi
if echo "$pass" | sudo -S sed -i "s/#GRUB_SAVEDEFAULT=true/GRUB_SAVEDEFAULT=true/" /etc/default/grub; then echo "'GRUB_SAVEDEFAULT' set to 'true'."; fi
if echo "$pass" | sudo -S sed -i "s/GRUB_DISABLE_SUBMENU='false'/GRUB_DISABLE_SUBMENU='true'/" /etc/default/grub; then echo "'GRUB_DISABLE_SUBMENU' set to 'true'."; fi

# add custom touchpad gestures
echo 'Section "InputClass"
Identifier "libinput touchpad catchall"
MatchIsTouchpad "on"
MatchDevicePath "/dev/input/event*"
Driver "libinput"
Option "Tapping" "on"
EndSection' | sudo tee /etc/X11/xorg.conf.d/30-touchpad.conf
