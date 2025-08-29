#!/usr/bin/env sh
# shellcheck disable=2015

convert_tall_pic() {
  convert "$1" -filter catrom -resize 1200x\< -quality 25% "../compressed/${newpic}.webp"
}

convert_wide_pic() {
  convert "$1" -filter catrom -resize 75% -quality 40% "../compressed/${newpic}.webp"
}

basedir="$PWD"
savedir="$HOME/Documents/manga"
[ -d "$savedir" ] || mkdir -p "$savedir"

if [ $# -eq 0 ]; then
  echo "no comics were provided, exiting"
  exit 1
fi

for comic in "$@"; do
  filename="$(basename "$comic")"

  if [ -f "$savedir/$filename" ]; then
    echo "$filename already exists"
    continue
  fi

  case "$comic" in *.cbz | *.cbr | *.zip)
    unzip "$comic" -d "/tmp/manga"
    cd /tmp/manga || exit
    mkdir raw compressed
    fd -i --glob "*.{jpg,png,jpeg,webp}" -x mv {} raw/
    cd raw || exit
    echo "conversion started"
    sleep 1

    for pic in *; do
      newpic="${pic%.*}"
      height=$(identify "$pic" | rg -oe "[[:digit:]]{3,4}x" | sed -n 1p | tr -d x)
      width=$(identify "$pic" | rg -oe "x[[:digit:]]{3,4}" | sed -n 1p | tr -d x)
      [ "$width" -lt "$height" ] && convert_tall_pic "$pic" || convert_wide_pic "$pic"
      echo "converted ${newpic}.webp"
    done
    zip -9 -m "$savedir/$filename" ../compressed/*
    cd ../..
    rm -rf manga
    cd "$basedir" || exit
    ;;
  *)
    echo "the parameter you privded isn't a valid comic, aborting."
    continue
    ;;
  esac
  continue
done
