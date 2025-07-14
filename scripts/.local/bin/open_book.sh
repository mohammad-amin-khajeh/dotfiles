#!/usr/bin/env bash
set -euo pipefail

pdf_reader="zathura"
launcher="rofi -dmenu -i -p book: "
book_dir="${HOME}/Documents/books"
cd "$book_dir"
books="$(find . -iname '*.pdf' -type f -exec ls -1t "{}" +)"
book="$(echo "$books" | $launcher)"
"$pdf_reader" "$book" &
