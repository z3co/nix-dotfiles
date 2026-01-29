#!/bin/bash

SERVICE_NAME="kanata"

systemctl --user status "$SERVICE_NAME" > /dev/null 2>&1

EXIT_CODE=$?

if [ "$EXIT_CODE" -eq 0 ]; then
	echo "{\"text\": \"  - kanata enabled\", \"class\": \"up\"}"
elif [ "$EXIT_CODE" -eq 3 ]; then
	echo "{\"text\": \"✗ - kanata disabled\", \"class\": \"down\"}"
else
	echo "{\"text\": \"  - Error\", \"class\": \"error\"}"
fi
