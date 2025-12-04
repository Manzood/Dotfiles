#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Toggle Menu Bar Auto Hide
# @raycast.mode silent
# @raycast.packageName System
# @raycast.icon 🧭

current=$(defaults read NSGlobalDomain _HIHideMenuBar 2>/dev/null)
if [ "$current" = "1" ]; then
    defaults write NSGlobalDomain _HIHideMenuBar -bool false
    status="shown"
else
    defaults write NSGlobalDomain _HIHideMenuBar -bool true
    status="hidden"
fi
# killall Finder
killall SystemUIServer 2>/dev/null || true
echo "Menu bar $status"

