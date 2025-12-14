#!/bin/bash
set -euo pipefail

~/.config/aerospace/bin/sync-sketchybar-gaps.sh
aerospace reload-config
