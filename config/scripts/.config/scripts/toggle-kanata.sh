#!/bin/bash

SERVICE_NAME="kanata"

systemctl --user status "$SERVICE_NAME" > /dev/null 2>&1

EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 0 ]; then
	systemctl --user stop "$SERVICE_NAME"
	notify-send -t 3000 "Stopped kanata"
elif [ "$EXIT_CODE" -eq 3 ]; then
	systemctl --user start "$SERVICE_NAME"
	notify-send -t 3000 "Started kanata"
else
	exit 1
fi
