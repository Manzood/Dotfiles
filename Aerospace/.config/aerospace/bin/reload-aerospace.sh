#!/bin/bash
set -euo pipefail

/bin/bash ~/.config/aerospace/bin/ensure-sketchybar-running.sh
~/.config/aerospace/bin/sync-sketchybar-gaps.sh
aerospace reload-config
