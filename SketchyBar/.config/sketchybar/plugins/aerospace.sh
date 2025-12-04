#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

WORKSPACE="$1"
ACTIVE_BG="${2:-0xffa6da95}"
INACTIVE_BG="${3:-0x221b1d2b}"
ACTIVE_FG="${4:-0xff1f1e2e}"
INACTIVE_FG="${5:-0xffb8c0e0}"

if [ -z "$WORKSPACE" ]; then
  exit 0
fi

if [ "$WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set "$NAME" \
      background.drawing=on \
      background.color="$ACTIVE_BG" \
      icon.color="$ACTIVE_FG" \
      label.color="$ACTIVE_FG"
else
  sketchybar --set "$NAME" \
      background.drawing=on \
      background.color="$INACTIVE_BG" \
      icon.color="$INACTIVE_FG" \
      label.color="$INACTIVE_FG"
fi
