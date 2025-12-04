#!/usr/bin/env bash

# Define all color palettes in this file so new schemes only require one edit.
# Add a new case branch with your palette and run sketchybar with COLOR_SCHEME=<name>.

load_colorscheme() {
  local scheme="$1"
  case "$scheme" in
    catppuccin)
      COLOR_BAR=0xe6191b2b
      COLOR_ITEM_BG=0x551f2335
      COLOR_ITEM_ALT=0x6631374f
      COLOR_ACCENT=0xfff5bde6
      COLOR_ACCENT_TEXT=0xff1e1e2e
      COLOR_TEXT=0xffcad3f5
      COLOR_DIM=0xff8aadf4
      COLOR_BORDER=0x332a2f41
      COLOR_GOOD=0xffa6da95
      COLOR_WARN=0xfff5a97f
      SPACE_ACTIVE_BG=0xfff4dbd6
      SPACE_INACTIVE_BG=0x441b1f30
      SPACE_ACTIVE_FG=0xff1e2030
      SPACE_INACTIVE_FG=0xffa6accd
      ;;
    catppuccin-light)
      COLOR_BAR=0xe6e6e9ef
      COLOR_ITEM_BG=0x55ccd0da
      COLOR_ITEM_ALT=0x66dce0e8
      COLOR_ACCENT=0xff7287fd
      COLOR_ACCENT_TEXT=0xff303446
      COLOR_TEXT=0xff4c4f69
      COLOR_DIM=0xff5c5f77
      COLOR_BORDER=0x334c4f69
      COLOR_GOOD=0xff40a02b
      COLOR_WARN=0xffdf8e1d
      SPACE_ACTIVE_BG=0xfff2d5cf
      SPACE_INACTIVE_BG=0x44ccd0da
      SPACE_ACTIVE_FG=0xff303446
      SPACE_INACTIVE_FG=0xff6c6f85
      ;;
    rose-pine)
      COLOR_BAR=0xe61f1d2f
      COLOR_ITEM_BG=0x552f2942
      COLOR_ITEM_ALT=0x6632354a
      COLOR_ACCENT=0xffeb6f92
      COLOR_ACCENT_TEXT=0xff1f1d2f
      COLOR_TEXT=0xffe0def4
      COLOR_DIM=0xff908caa
      COLOR_BORDER=0x332c223b
      COLOR_GOOD=0xff9ccfd8
      COLOR_WARN=0xfff6c177
      SPACE_ACTIVE_BG=0xffebbcba
      SPACE_INACTIVE_BG=0x44201c31
      SPACE_ACTIVE_FG=0xff191724
      SPACE_INACTIVE_FG=0xff908caa
      ;;
    rose-pine-light)
      COLOR_BAR=0xe6f2e9e1
      COLOR_ITEM_BG=0x55efe6de
      COLOR_ITEM_ALT=0x66f7ede3
      COLOR_ACCENT=0xffb4637a
      COLOR_ACCENT_TEXT=0xff26233a
      COLOR_TEXT=0xff575279
      COLOR_DIM=0xff797593
      COLOR_BORDER=0x33575279
      COLOR_GOOD=0xff56949f
      COLOR_WARN=0xffea9d34
      SPACE_ACTIVE_BG=0xfff5d0c5
      SPACE_INACTIVE_BG=0x44e7dcd6
      SPACE_ACTIVE_FG=0xff26233a
      SPACE_INACTIVE_FG=0xff9893a5
      ;;
    *)
      echo "sketchybar: unknown color scheme '$scheme', falling back to catppuccin" >&2
      load_colorscheme catppuccin
      ;;
  esac
}
