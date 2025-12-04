#!/usr/bin/env bash

truncate_text() {
  local text="$1"
  local max_length="${2:-32}"

  if [ "${#text}" -le "$max_length" ]; then
    printf "%s" "$text"
  else
    printf "%s…" "${text:0:$((max_length-1))}"
  fi
}

read_spotify() {
  osascript <<'APPLESCRIPT'
if application "Spotify" is running then
  tell application "Spotify"
    set playerState to player state as text
    if playerState is "playing" or playerState is "paused" then
      set trackName to name of current track
      set artistName to artist of current track
      return playerState & "||" & trackName & "||" & artistName
    else
      return playerState & "||||"
    end if
  end tell
else
  return "stopped||||"
end if
APPLESCRIPT
}

parse_field() {
  local input="$1"
  local idx="$2"
  local result="$input"
  local i

  for ((i=0; i<idx; i++)); do
    result="${result#*||}"
  done

  if [[ "$result" == *"||"* ]]; then
    result="${result%%||*}"
  fi

  printf "%s" "$result"
}

raw="$(read_spotify)"

state="$(parse_field "$raw" 0)"
track="$(parse_field "$raw" 1)"
artist="$(parse_field "$raw" 2)"

if [ -z "$state" ]; then
  state="stopped"
fi

label=""
draw_label="off"

track="$(printf "%s" "$track" | tr -d '\r\n')"
artist="$(printf "%s" "$artist" | tr -d '\r\n')"

if [ -n "$track" ] || [ -n "$artist" ]; then
  if [ -n "$track" ] && [ -n "$artist" ]; then
    label="$track — $artist"
  elif [ -n "$track" ]; then
    label="$track"
  else
    label="$artist"
  fi
  max_label_length="${SPOTIFY_LABEL_MAX:-30}"
  label="$(truncate_text "$label" "$max_label_length")"
  draw_label="on"
fi

icon=""
icon_color="0xff6e738d"

if [ "$state" = "playing" ]; then
  icon="󰓇"
  icon_color="0xff81c8be"
elif [ "$state" = "paused" ] && [ "$draw_label" = "on" ]; then
  icon="󰏤"
  icon_color="0xfff5a97f"
elif [ "$state" = "paused" ]; then
  icon="󰏤"
  icon_color="0xffa6accd"
fi

if [ "$draw_label" = "on" ]; then
  sketchybar --set "$NAME" \
    icon="$icon" \
    icon.color="$icon_color" \
    label="$label" \
    label.drawing=on \
    background.drawing=on \
    background.padding_left=12 \
    background.padding_right=12
else
  sketchybar --set "$NAME" \
    icon="$icon" \
    icon.color="0xfff5bde6" \
    label="" \
    label.drawing=off \
    background.drawing=off \
    background.padding_left=0 \
    background.padding_right=0
fi
