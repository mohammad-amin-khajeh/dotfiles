#!/usr/bin/env bash

workspace="$(echo "$1" | tr -d '"')"
if [[ "$(i3-msg -t get_tree | grep -i "$1")" == "" ]]; then
	"$2"
fi
