#!/bin/bash
set -euo pipefail

CONFIG_PATH="${HOME}/.config/aerospace/aerospace.toml"

# Tune these if you want different headroom.
BUILT_IN_TOP=8
DESKTOP_TOP_WITH_SKETCHYBAR=36
DESKTOP_TOP_WITHOUT_SKETCHYBAR=8

sketchybar_status() {
    # Prints "shown", "hidden", or "missing"
    local query exit_code
    set +e
    query="$(sketchybar --query bar 2>/dev/null)"
    exit_code=$?
    set -e

    if [ "$exit_code" -ne 0 ]; then
        printf 'missing\n'
        return
    fi

    if printf '%s\n' "$query" | grep -Eiq 'hidden[[:space:]:="]*on|hidden[[:space:]:="]*true|hidden[[:space:]:="]*1'; then
        printf 'hidden\n'
        return
    fi
    # If you explicitly use `hidden=off` to hide the bar, export SKETCHYBAR_HIDDEN_IS_OFF=1 before calling this script.
    if [ "${SKETCHYBAR_HIDDEN_IS_OFF:-0}" -eq 1 ] && printf '%s\n' "$query" | grep -Eiq 'hidden[[:space:]:="]*off|hidden[[:space:]:="]*false|hidden[[:space:]:="]*0'; then
        printf 'hidden\n'
        return
    fi
    printf 'shown\n'
}

bar_state="missing"
bar_state="$(sketchybar_status)"

case "$bar_state" in
    shown) target_top="$DESKTOP_TOP_WITH_SKETCHYBAR" ;;
    hidden) target_top="$DESKTOP_TOP_WITHOUT_SKETCHYBAR" ;;
    *) target_top="$DESKTOP_TOP_WITHOUT_SKETCHYBAR" ;;
esac

export CONFIG_PATH BUILT_IN_TOP target_top

# Run the rewrite step without failing the whole script on non-zero exit.
set +e
python3 - "$CONFIG_PATH" <<'PY'
import os
import pathlib
import re
import sys

cfg_path = pathlib.Path(os.environ["CONFIG_PATH"])
built_top = os.environ["BUILT_IN_TOP"]
default_top = os.environ["target_top"]

try:
    content = cfg_path.read_text()
except FileNotFoundError:
    sys.exit(1)

pattern = re.compile(
    r'outer\.top\s*=\s*\[\s*\{[^}]*monitor\.\"Built-in Retina Display\"\s*=\s*\d+\s*\}\s*,\s*\d+\s*\]',
    re.DOTALL,
)
replacement = (
    'outer.top = [\n'
    f'        {{ monitor."Built-in Retina Display" = {built_top} }} ,\n'
    f'        {default_top}\n'
    '    ]'
)

if not pattern.search(content):
    sys.exit(2)

new_content = pattern.sub(replacement, content, count=1)
if new_content != content:
    cfg_path.write_text(new_content)
    sys.exit(1)

sys.exit(0)
PY
status=$?
set -e

case "$status" in
    0) : ;;                # No change
    1) aerospace reload-config >/dev/null 2>&1 || true ;;  # Updated
    2) echo "pattern for outer.top not found; no changes made" >&2 ;;
    *) echo "sync-sketchybar-gaps: unexpected status ${status}" >&2 ;;
esac
