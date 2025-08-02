#!/usr/bin/env bash

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 filename search_term1 [search_term2 ...]"
  exit 1
fi

filename=$1
shift # Remove filename from the arguments, now $@ contains search terms

# Build grep pattern for multiple terms (OR)
# Escape each term and join with \| for grep -E
pattern=$(printf '%s|' "$@")
pattern=${pattern%|} # Remove trailing |

total_minutes=0

while IFS= read -r line; do
  [[ "$line" == *"=>"* ]] && continue
  if [[ $line =~ ([0-9]+):([0-9]+)$ ]]; then
    h=$((10#${BASH_REMATCH[1]}))
    m=$((10#${BASH_REMATCH[2]}))
    ((total_minutes += h * 60 + m))
  fi
done < <(grep -E -- "$pattern" "$filename")

total_h=$((total_minutes / 60))
total_m=$((total_minutes % 60))

printf "Total time spent on '%s': %d:%02d\n" "$*" "$total_h" "$total_m"
