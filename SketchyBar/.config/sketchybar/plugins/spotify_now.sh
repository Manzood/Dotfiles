#!/usr/bin/env bash

truncate_text() {
  local text="$1"
  local max_length="${2:-32}"

  # Keep the label within the byte budget so sketchybar won't cut UTF-8 mid-codepoint
  python3 - "$text" "$max_length" <<'PY'
import sys

text = sys.argv[1]
max_len = int(sys.argv[2])
ellipsis = "…"
ellipsis_bytes = len(ellipsis.encode("utf-8"))

encoded = text.encode("utf-8")
if len(encoded) <= max_len:
    sys.stdout.write(text)
    sys.exit(0)

budget = max_len - ellipsis_bytes
if budget < 0:
    budget = 0

current = 0
chars = []
for ch in text:
    b = len(ch.encode("utf-8"))
    if current + b > budget:
        break
    chars.append(ch)
    current += b

sys.stdout.write("".join(chars) + ellipsis)
PY
}

spotify_running() {
  pgrep -x "Spotify" >/dev/null 2>&1
}

read_spotify() {
  if ! spotify_running; then
    printf "stopped||||"
    return
  fi

  # Use System Events to check process existence - this doesn't trigger app launches
  # unlike directly addressing "application Spotify" which can relaunch a closing app
  osascript <<'APPLESCRIPT'
tell application "System Events"
  if not (exists process "Spotify") then
    return "stopped||||"
  end if
end tell

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
