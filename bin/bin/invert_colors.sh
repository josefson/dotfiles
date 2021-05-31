#!/bin/bash

if [ "$(pidof picom)" ];then
    pkill picom
else
    ID=$(xdotool getactivewindow)
    CLASS=$(xprop -id "$ID"  | grep "WM_CLASS" | awk '{print $4}')
    COND="class_g=${CLASS}"
    picom --invert-color-include "$COND" &
fi
exit
