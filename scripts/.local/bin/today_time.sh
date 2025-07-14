#!/bin/bash

# gives the total studying, work time of the last logged day
# the following format is mandatory:
# *empty line*
# %664 days left%
# *** 13 Sun => 3:35 %6 pages read - at 18%
#     ~ anki: 2:08
#     ~ leetcode: 0:07
#     ~ study proof writing - how to prove it: 1:20
#
# only the lines beginning with ~ are considered.

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 filename"
  exit 1
fi

filename=$1
max_tasks_in_a_day=30

tail -n "$max_tasks_in_a_day" "$filename" |
  tac |
  awk '
  !NF { exit }
  $1=="~" {
    if (match($0, /([0-9]+):([0-9]{2})[[:space:]]*$/, m)) {
      h = m[1] + 0
      mns = m[2] + 0
      total_minutes += h * 60 + mns
    }
  }
  END {
    hours = int(total_minutes / 60)
    minutes = total_minutes % 60
    printf "%d:%02d\n", hours, minutes
  }
'
