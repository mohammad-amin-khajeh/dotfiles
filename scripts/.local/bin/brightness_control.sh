#!/bin/bash
set -euo pipefail

# Set your output and initial brightness value
output="eDP-1"
current_brightness=$(xrandr --verbose | grep "$output" -A 5 | grep Brightness | awk '{print $2}')

# Set the step size for brightness adjustment
step=0.1

# Check the argument passed to the script
case "$1" in
    "increase")
        new_brightness=$(echo "$current_brightness + $step" | bc)
        ;;
    "decrease")
        new_brightness=$(echo "$current_brightness - $step" | bc)
        ;;
    *)
        echo "Usage: $0 {increase|decrease}"
        exit 1
        ;;
esac

# Ensure the brightness value is within the valid range
new_brightness=$(awk -v nb="$new_brightness" 'BEGIN{if(nb>1.0){print 1.0}else if(nb<0.1){print 0.1}else{print nb}}')

# Set the new brightness value
xrandr --output "$output" --brightness "$new_brightness"

