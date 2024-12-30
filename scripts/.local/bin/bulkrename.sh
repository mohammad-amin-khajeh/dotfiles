#!/bin/bash

set -euo pipefail
shopt -s nullglob

num=01
find *.srt && ext="srt" || ext="ass"

for sub in *.{srt,ass}; do
	mv "$sub" "$num.$ext"
	num=$(expr "$num" + 1)
	num=$(printf "%02d" "$num")
done

for file in *.mkv; do
	sub="$(command ls *."$ext" | awk 'NR==1')"
	mv -v "$sub" "${file%mkv}$ext"
done
