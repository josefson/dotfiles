#!/bin/bash

fold="$HOME/.config/pianobar"
ctlf="$fold/ctl"
nowplaying="$fold/lyrics.sh"

#	songstart)
while read L; do
        k="`echo "$L" | cut -d '=' -f 1`"
        v="`echo "$L" | cut -d '=' -f 2`"
        export "$k=$v"

done < <(grep -e '^\(title\|artist\|album\|stationName\|songStationName\|pRet\|pRetStr\|wRet\|wRetStr\|songDuration\|songPlayed\|rating\|coverArt\|stationCount\|station[0-9]*\)=' /dev/stdin) # don't overwrite $1...

case "$1" in
        songstart)
            echo -e "glyrc lyrics -a \"$artist\" -t \"$title\" -b \"$album\" -w /tmp/" > "$nowplaying"
            reattach-to-user-namespace terminal-notifier -subtitle  "Artist: $artist" -message "Album: $album" -title "$title"
            ;;
        # songfinish)
        #     ;;
esac
