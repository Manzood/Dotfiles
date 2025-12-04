#!/usr/bin/env bash

AIRPORT_BIN="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"

wifi_icon() {
  local rssi="$1"

  if [ -z "$rssi" ]; then
    printf "󰤭"
    return
  fi

  if [ "$rssi" -ge -55 ]; then
    printf "󰤨"
  elif [ "$rssi" -ge -67 ]; then
    printf "󰤥"
  elif [ "$rssi" -ge -75 ]; then
    printf "󰤢"
  else
    printf "󰤟"
  fi
}

DEVICE="$(networksetup -listallhardwareports 2>/dev/null | awk '/Wi-Fi/{getline; print $2; exit}')"

if [ -z "$DEVICE" ]; then
  sketchybar --set "$NAME" icon="󰤮" label="No Wi-Fi"
  exit 0
fi

CURRENT_NETWORK="$(networksetup -getairportnetwork "$DEVICE" 2>/dev/null)"

if [[ "$CURRENT_NETWORK" == *"You are not associated"* ]]; then
  sketchybar --set "$NAME" icon="󰤭" label="Offline"
  exit 0
fi

SSID="${CURRENT_NETWORK#*: }"

if [ -z "$SSID" ]; then
  sketchybar --set "$NAME" icon="󰤭" label="Offline"
  exit 0
fi

RSSI=""
if [ -x "$AIRPORT_BIN" ]; then
  AIRPORT_OUTPUT="$("$AIRPORT_BIN" -I 2>/dev/null)"
  RSSI="$(echo "$AIRPORT_OUTPUT" | awk '/agrCtlRSSI/ {print $2; exit}')"
fi

sketchybar --set "$NAME" icon="$(wifi_icon "$RSSI")" label="$SSID"
