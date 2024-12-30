#!/usr/bin/env bash

fetch_speed() {
	awk '{if(l1){printf("  %.1f / %.1f MB/s\n", ($2-l1)/1024/1024, ($10-l2)/1024/1024)} else{l1=$2; l2=$10;}}' \
		<(grep wlan0 /proc/net/dev) <(
			sleep 1
			grep wlan0 /proc/net/dev
		)
}

while true; do
	fetch_speed
done
