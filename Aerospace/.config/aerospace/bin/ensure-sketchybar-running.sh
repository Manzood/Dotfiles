#!/bin/bash
set -euo pipefail

# Keep this script intentionally simple and best-effort.
# If SketchyBar is already running, do nothing.
if pgrep -x sketchybar >/dev/null 2>&1; then
  exit 0
fi

# Start SketchyBar via Homebrew services (best-effort).
/opt/homebrew/bin/brew services start sketchybar >/dev/null 2>&1 || true

exit 0
