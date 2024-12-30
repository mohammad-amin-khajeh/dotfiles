#!/bin/bash
set -euo pipefail

uuid=8CD416D4D416C07E
if [ -z "lsblk -f | rg $uuid" ]; then notify-send 'the device is unplugged' -t 1500; exit 1; fi
check() {
  lsblk -f | rg "$1" | awk '{print $NF}'
}

mounted=`check "$uuid"`

if [ -n "lsblk -f | rg $uuid" ] && [[ "$mounted" == "$uuid" ]]
then 
  sudo mount -U "$uuid" ~/Documents/harddrive/
  notify-send 'device mounted successfully ✅' -t 1500
  exit 0
else
  sudo umount ~/Documents/harddrive
  notify-send 'device unmounted successfully ✅' -t 1500
  exit 0
fi
