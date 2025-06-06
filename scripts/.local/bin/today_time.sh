#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

filename=$1

# Extract the last paragraph: last block of non-empty lines
# Approach:
# 1. Reverse the file lines
# 2. Collect lines until we hit an empty line (which marks paragraph boundary)
# 3. Reverse back to original order

last_paragraph=$(tac "$filename" | awk '
  NF {print; blank=0} 
  !NF && blank==0 {blank=1; exit}
' | tac)

total_minutes=0

# Process each line in the last paragraph
while IFS= read -r line; do
  # Skip lines containing =>
  [[ "$line" == *"=>"* ]] && continue

  # Extract time at line end h:m
  if [[ $line =~ ([0-9]+):([0-9]+)$ ]]; then
    h=$((10#${BASH_REMATCH[1]}))
    m=$((10#${BASH_REMATCH[2]}))
    ((total_minutes += h * 60 + m))
  fi
done <<<"$last_paragraph"

total_h=$((total_minutes / 60))
total_m=$((total_minutes % 60))

printf "Total time in last paragraph: %d:%02d\n" "$total_h" "$total_m"
