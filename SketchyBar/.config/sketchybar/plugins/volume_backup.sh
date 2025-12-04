#!/bin/sh

get_volume() {
  osascript -e 'output volume of (get volume settings)' 2>/dev/null
}

set_volume_icon() {
  local volume="${1:-0}"

  if [ "$volume" -ge 80 ]; then
    printf "󰕾"
  elif [ "$volume" -ge 40 ]; then
    printf "󰖀"
  elif [ "$volume" -ge 1 ]; then
    printf "󰕿"
  else
    printf "󰖁"
  fi
}

update_volume() {
  local volume="$1"

  if [ -z "$volume" ]; then
    volume="$(get_volume)"
  fi

  if [ -z "$volume" ]; then
    volume=0
  fi

  local icon
  icon="$(set_volume_icon "$volume")"

  sketchybar --set "$NAME" icon="$icon" label="${volume}%"
}

case "$SENDER" in
  "volume_change") update_volume "$INFO" ;;
  *) update_volume ;;
esac
