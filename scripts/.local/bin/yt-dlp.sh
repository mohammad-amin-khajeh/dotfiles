#!/usr/bin/env bash

content_type="$1"
url="$2"

if [[ "$content_type" == "v" ]]; then
  opts=""
elif [[ "$content_type" == "m" ]]; then
  opts="-f 140"
fi

dunstify yt-dlp "downloading..." -t 2000

[[ "$opts" != "" ]] && yt-dlp --cookies-from-browser firefox "$opts" "$url" || yt-dlp --cookies-from-browser firefox "$url"

if [[ $? -eq 0 ]]; then
  dunstify "downloaded successfully✅" -t 2000
else
  dunstify "failed to download❌" -t 2000
fi
