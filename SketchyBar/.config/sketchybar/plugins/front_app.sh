#!/bin/zsh
# #!/bin/sh

# Some events send additional information specific to the event in the $INFO
# variable. E.g. the front_app_switched event sends the name of the newly
# focused application in the $INFO variable:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting




# default config
# if [ "$SENDER" = "front_app_switched" ]; then
#   sketchybar --set "$NAME" label="$INFO"
# fi
# /default config


ICON_PADDING=5

case $INFO in
"Arc")
    ICON_PADDING=5
    ICON=󰞍
    ;;
"Code")
    ICON_PADDING=4
    ICON=󰨞
    ;;
"Calendar")
    ICON_PADDING=3
    ICON=
    ;;
"Discord")
    ICON=
    ;;
"FaceTime")
    ICON_PADDING=5
    ICON=
    ;;
"Finder")
    ICON=󰀶
    ;;
"Google Chrome")
    ICON_PADDING=7
    ICON=
    ;;
"IINA")
    ICON_PADDING=4
    ICON=󰕼
    ;;
"kitty")
    ICON=󰄛
    ;;
"Messages")
    ICON=
    ;;
"Notion")
    ICON_PADDING=6
    ICON=󰎚
    ;;
"Preview")
    ICON_PADDING=3
    ICON=
    ;;
"PS Remote Play")
    ICON_PADDING=3
    ICON=
    ;;
"Spotify")
    ICON_PADDING=2
    ICON=
    ;;
"TextEdit")
    ICON_PADDING=4
    ICON=
    ;;
"Transmission")
    ICON_PADDING=3
    ICON=󰶘
    ;;
*)
    ICON_PADDING=2
    ICON=
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.padding_left=$ICON_PADDING icon.padding_right=$ICON_PADDING
sketchybar --set $NAME.name label="$INFO"
