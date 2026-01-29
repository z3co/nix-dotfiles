#!/bin/bash

CATEGORIES=(
    "SCHOOL"
    "PROGRAMMING"
		"WASTE" 
		"STOP"
)

selected=$(printf "%s\n" "${CATEGORIES[@]}" | fzf --margin 10%)
sk_status=$?

if [[ $sk_status -ne 0 || -z "$selected" ]]; then
    exit 0
fi

tmux set -g status-interval 5

if [[ "$selected" == "STOP" ]]; then
    timew stop > /dev/null 2>&1
    tmux set -g status-right ""
else
    timew start "$selected" > /dev/null 2>&1
    tmux set -g status-right "$selected #(timew | awk '/^ *Total/ {print \$NF}')"

	#	if [[ "$selected" == "WASTE" ]]; then
	#	else 
	#	fi

fi
