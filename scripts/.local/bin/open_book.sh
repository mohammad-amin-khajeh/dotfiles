#!/usr/bin/env sh

# gives you a list of books to choose from using rofi/dmenu
# the books are sorted by modified date in descending order(newest first)

pdf_reader="zathura"
launcher="rofi -dmenu -i -p book: "
book_dir="${HOME}/Documents/books"

if [ -z "$(command -v $pdf_reader)" ]; then
  printf "the pdf reader '%s' is not installed\nexiting\n" "$pdf_reader"
  exit 1
fi

if [ ! -d "$book_dir" ]; then
  printf "the directory '%s' does not exist\nexiting\n" "$book_dir"
  exit 1
fi

is_book_extension() {
  grep -iE '\.(pdf|epub|djvu|cbz|cbr)$'
}

list_books() {
  find -L "$book_dir" -maxdepth 2 -type f -printf '%T@ %P\n' \
    | sort -nr \
    | cut -d ' ' -f 2- \
    | is_book_extension
}

books="$(list_books)"
book="$(echo "$books" | $launcher)"
[ "$book" != "" ] && "$pdf_reader" "$book_dir/$book" &
