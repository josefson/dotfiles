#!/bin/bash
setxkbmap -option
setxkbmap -layout "us,us,br" -variant ",intl," -option grp:alt_space_toggle -option altwin:swap_lalt_lwin -option shift:both_capslock_cancel -option caps:ctrl_modifier
killall xcape
xcape -e 'Caps_Lock=Escape' 
