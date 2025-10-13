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


ICON_PADDING_RIGHT=5

case $INFO in
"Arc")
    ICON_PADDING_RIGHT=5
    ICON=󰞍
    ;;
"Code")
    ICON_PADDING_RIGHT=4
    ICON=󰨞
    ;;
"Calendar")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Discord")
    ICON=
    ;;
"FaceTime")
    ICON_PADDING_RIGHT=5
    ICON=
    ;;
"Finder")
    ICON=󰀶
    ;;
"Google Chrome")
    ICON_PADDING_RIGHT=7
    ICON=
    ;;
"IINA")
    ICON_PADDING_RIGHT=4
    ICON=󰕼
    ;;
"kitty")
    ICON=󰄛
    ;;
"Messages")
    ICON=
    ;;
"Notion")
    ICON_PADDING_RIGHT=6
    ICON=󰎚
    ;;
"Preview")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"PS Remote Play")
    ICON_PADDING_RIGHT=3
    ICON=
    ;;
"Spotify")
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
"TextEdit")
    ICON_PADDING_RIGHT=4
    ICON=
    ;;
"Transmission")
    ICON_PADDING_RIGHT=3
    ICON=󰶘
    ;;
*)
    ICON_PADDING_RIGHT=2
    ICON=
    ;;
esac

sketchybar --set $NAME icon=$ICON icon.padding_right=$ICON_PADDING_RIGHT
sketchybar --set $NAME.name label="$INFO"
