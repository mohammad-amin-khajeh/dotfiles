#!/usr/bin/env bash
set -euo pipefail

pdf_reader="zathura"
launcher="rofi -dmenu -i -p book: "
book_dir="${HOME}/Documents/books"
cd "$book_dir"
book="$(find *.pdf . | $launcher)"
"$pdf_reader" "$book"
