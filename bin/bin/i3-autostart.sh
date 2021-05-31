#!/usr/bin/env bash

# SETTINGS
# Display Power Manage - Prevent Display from blanking
xset s off -dpms
# requires tlp/tlprwd
bluetooth off
wwan off
wifi on
# requires light
light -S 50

# Caps->Control Alt_L<->Super_L LR_Shift->Caps
source $HOME/bin/screen.sh
source $HOME/bin/keyboard.sh
# Wallpaper
feh --bg-scale ~/.wallpaper

# LAYOUTS
i3-msg "workspace 1:Waystone; append_layout $HOME/.layouts/w1.json"
i3-msg "workspace 2:Eolian; append_layout $HOME/.layouts/w2.json"

# APPS
i3-msg "exec --no-startup-id urxvt -title weechat -e tmux new -s weechat weechat"
i3-msg "exec --no-startup-id urxvt -title pianobar -e tt start pandora"
i3-msg "exec --no-startup-id telegram-desktop"
i3-msg "exec --no-startup-id keepassxc"
i3-msg "exec --no-startup-id flameshot"
# DAEMONS
i3-msg "exec --no-startup-id mpd"
i3-msg "exec --no-startup-id mpdscribble"
i3-msg "exec --no-startup-id keynav daemonize"
i3-msg "exec --no-startupd-id unclutter"
i3-msg "exec --no-startup-id dunst"

$exec barrierc --name haven --no-restart --enable-drag-drop --enable-crypto --daemon 192.168.0.60
$exec syncthing
# $exec syncthing-gtk -m
# $exec $HOME/bin/quake.py -n quake_top
# $exec $HOME/bin/quake.py -n quake_bottom
# $exec $HOME/bin/quake.py -n quake_right
# $exec $HOME/bin/quake.py -n quake_left
