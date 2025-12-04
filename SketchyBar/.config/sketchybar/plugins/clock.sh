#!/bin/sh

FORMAT="%a %b %d · %I:%M %p"

sketchybar --set "$NAME" label="$(date +"$FORMAT")"
