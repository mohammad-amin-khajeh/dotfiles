#!/usr/bin/env sh

# gives you a list of your books to choose from using rofi/dmenu
# the first entry, called 'last', opens the last book you opened
# run the script with no args

reader="zathura"
reader_cmd="zathura"
launcher="rofi -dmenu -i -p book: "
book_dir="${HOME}/Documents/books"
lastbook_path="${HOME}/.cache/lastbook"

if [ -z "$(command -v "$reader")" ]; then
  printf "the pdf reader '%s' is not installed\nexiting\n" "$reader"
  exit 1
fi

if [ ! -d "$book_dir" ]; then
  printf "the directory '%s' does not exist\nexiting\n" "$book_dir"
  exit 1
fi

is_book_extension() {
  grep -iE '\.(pdf|epub|djvu|cbz|cbr|azw|mobi3)$'
}

list_books() {
  # HACK: you can change "%T@" to "%s" to sort based on filesize
  # as opposed to modified date

  sort_param="%T@"
  find -L "$book_dir" -maxdepth 2 -type f -printf "$sort_param %P\n" |
    sort -nr |
    cut -d ' ' -f 2- |
    is_book_extension
}

open_book() {
  chosen_book="$1"

  if [ -f "$lastbook_path" ]; then
    lastbook="$(cat "$lastbook_path")"
  else
    lastbook=""
  fi

  if [ "$chosen_book" = "last" ]; then

    if [ -n "$lastbook" ]; then
      "$reader_cmd" "$book_dir/$lastbook"
    else
      printf "No last book found\n"
      exit 1
    fi

  else
    echo "$chosen_book" >"$lastbook_path"
    "$reader_cmd" "$book_dir/$chosen_book"
  fi
}

books="$(list_books)"
last="last
"
books="${last}${books}"
book="$(echo "$books" | $launcher)"
[ "$book" != "" ] && open_book "$book" &
