#!/bin/bash

# nvidia drivers
# lvds_string=$(xrandr | grep -E "^LVDS\S+1") 
# vga_string=$(xrandr | grep -E "^VGA\S+1") 
# hdmi_string=$(xrandr | grep -E "^HDMI\S+1") 

# nouveau drivers
lvds_string=$(xrandr | grep -E "^LVDS\S") 
vga_string=$(xrandr | grep -E "^VGA\S") 
hdmi_string=$(xrandr | grep -E "^HDMI\S") 

DEFAULT=$(echo $lvds_string | cut -d ' ' -f 1)
DEFAULT_STATUS=$(echo $lvds_string | cut -d ' ' -f 2)

HDMI=$(echo $hdmi_string | cut -d ' ' -f 1)
HDMI_STATUS=$(echo $hdmi_string | cut -d ' ' -f 2)

VGA=$(echo $vga_string | cut -d ' ' -f 1)
VGA_STATUS=$(echo $vga_string | cut -d ' ' -f 2)

picture=~/.wallpaper

update_wallpaper(){
    feh --bg-scale $picture
}

if [[ $# -eq 0 ]]; then
    if echo $VGA_STATUS | grep "disconnected" && echo $HDMI_STATUS | grep "disconnected"; then
        xrandr --output "$VGA" --off --output "$HDMI" --off --output "$DEFAULT" --primary --auto
        update_wallpaper
    elif echo $VGA_STATUS | grep "connected" && echo $HDMI_STATUS | grep "disconnected"; then
        xrandr --output "$VGA" --primary --auto --output "$HDMI" --off --output "$DEFAULT" --auto --left-of "$VGA"
        update_wallpaper
    elif echo $VGA_STATUS | grep "disconnected" && echo $HDMI_STATUS | grep "connected"; then
        xrandr --output "$VGA" --off --output "$HDMI" --primary --auto --output "$DEFAULT" --auto --left-of "$HDMI"
        update_wallpaper
    fi
fi
