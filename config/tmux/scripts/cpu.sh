#!/bin/bash

TMP_FILE=/tmp/tmux_cpu_usage_persistent

~/.config/tmux/scripts/cpu_update.sh "$TMP_FILE"&

# Immediately print the current (last) value from the persistent file,
# so that subsequent calls show the old value until a new calculation completes.
if [ -f "$TMP_FILE" ]; then
  tail -n 1 "$TMP_FILE"
else
  echo "0"
fi

