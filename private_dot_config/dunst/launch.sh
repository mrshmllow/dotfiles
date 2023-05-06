#!/bin/bash

CONFIG_FILES="$HOME/.config/dunst/dunstrc"

trap "killall dunst" EXIT

while true; do
    waybar &
    inotifywait -e create,modify $CONFIG_FILES
    killall dunst
done
