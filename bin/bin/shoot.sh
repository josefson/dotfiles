#!/usr/bin/zsh

window=0
fullscreen=0
selection=0
clipboard=0
imgur=0

HELP(){
    echo '
    ./script.sh [mode] [dest]
    ./script.sh [-w|-f|-s] [-c]
    -w focused window
    -f fullscreen
    -s selection
    -i imgur
    -c clipboard, if not set it will save to file and copy to clipboard
    Dependencies: xdotool and maim(scroot replacement)'
}

while getopts 'wfscih' FLAG; do
    case $FLAG in
        w)
            window=1
            ;;
        f)
            fullscreen=1
            ;;
        s)
            selection=1
            ;;
        c)
            clipboard=1
            ;;
        i)
            imgur=1
            ;;
        h)
            HELP
            ;;
    esac
done

active_window=$(xdotool getactivewindow)
shots_path="$HOME/Pictures/screenshots"
filename=$shots_path/$(date +%Y_%m_%d-%H-%M-%S).png

#if saving to file and dir doesnt exist, create it
if [[ $clipboard == 0 ]]; then
    if [[ ! -d "$shots_path" ]]; then
        mkdir -p $shots_path
    fi
fi
#if fullscreen: clip 1 or 0
if [[ $imgur == 1 ]]; then
    #imgur.sh puts link in --primary, so put primary into clipboard
    maim -s /tmp/screenshot.png; imgur.sh /tmp/screenshot.png
    xclip -o -selection primary | xclip -in -selection clipboard
#if focused window: clip 1 or 0
elif [[ $window == 1 ]]; then
    if [[ $clipboard == 1 ]]; then
        maim -i $active_window | xclip -selection clipboard -t image/png
    elif [[ $clipboard == 0 ]]; then
        maim -i $active_window $filename && xclip -selection clipboard \
            -t image/png -i $filename
    fi
#if fullscreen: clip 1 or 0
elif [[ $fullscreen == 1 ]]; then
    if [[ $clipboard == 1 ]]; then
        maim | xclip -selection clipboard -t image/png
    elif [[ $clipboard == 0 ]]; then
        maim $filename && xclip -selection clipboard -t image/png -i $filename
    fi
# if selection: clip 1 or 0
elif [[ $selection == 1 ]]; then
    if [[ $clipboard == 1 ]]; then
        maim -s | xclip -selection clipboard -t image/png
        sleep 20
        echo '' | xclip -selection clipboard
    elif [[ $clipboard == 0 ]]; then
        maim -s $filename && xclip -selection clipboard -t image/png -i $filename
    fi
fi
