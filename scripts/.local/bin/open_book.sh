#!/usr/bin/env sh

pdf_reader="zathura"
launcher="rofi -dmenu -i -p book: "
book_dir="${HOME}/Documents/books"
cd "$book_dir" || exit
books="$(find . \( -name '*.pdf' -o -name '*.epub' -o -name '*.djvu' \) -type f -exec ls -1t "{}" +)"
book="$(echo "$books" | $launcher)"
[ "$book" != "" ] && "$pdf_reader" "$book" &
