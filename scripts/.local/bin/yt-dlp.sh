#!/usr/bin/env bash

content_type="$1"
url="$2"

if [[ "$content_type" == "v" ]]; then
  opts=""
elif [[ "$content_type" == "m" ]]; then
  opts="-f 140"
fi

dunstify yt-dlp "downloading..." -t 2000

if [[ "$opts" != "" ]]; then
  yt-dlp "$opts" "$url"
else
  yt-dlp "$url"
fi

if [[ $? -eq 0 ]]; then
  dunstify "yt-dlp" "downloaded successfully✅" -t 2000
else
  dunstify "yt-dlp" "failed to download❌" -t 2000
fi
