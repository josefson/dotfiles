!#/usr/bin/bash
xdg-open "$(locate home | rofi -threads 0 \
    -color-window '#000000, #000000, #000000' \
    -color-normal '#000000, #ff4000, #000000, #ff4000, #000000' \
    -color-active '#000000, #ff4000, #000000, #ff4000, #000000' \
    -color-urgent '#000000, #ff4000, #000000, #ff4000, #000000' \
    -dmenu -i -p 'locate:')"
