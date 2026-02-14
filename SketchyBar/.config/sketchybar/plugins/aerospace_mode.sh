#!/usr/bin/env bash

MODE=$(aerospace list-modes --current 2>/dev/null)

if [ "$MODE" = "main" ] || [ -z "$MODE" ]; then
  sketchybar --set "$NAME" drawing=off
else
  sketchybar --set "$NAME" drawing=on label="$MODE"
fi
