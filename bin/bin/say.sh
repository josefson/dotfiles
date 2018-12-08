#!/bin/bash

voices_dir=$HOME/.config/voices/
default_voice='slt'
default_speed='0.8'
voice_path=
speed=
voice=
file=

HELP(){
message="-s|--speed
-v|--voice
-f|--file
-l|--list list voices
examples:
   script.sh text to be read
   script.sh -s 0.5 -v slt -f my_file
   script.sh -s 0.8 -v slt this is a test
Dependencies: flite and flitevox voices."
echo "${message}"
}

die(){
    printf '%s\n' "$1" >&2
    exit 1
}

demo(){
    demo_msg="Call a jack a jack. Call a spade a spade. But always call a whore a lady. Their lives are hard enough, and it never hurts to be polite."
    for filename in ${voices_dir}*
    do
        echo $filename
        if [[ "$1" ]]; then
            flite -voice "$filename" --setf duration_stretch=0.8 -t "$1"
        else
            flite -voice "$filename" --setf duration_stretch=0.8 -t "$demo_msg"
        fi
    done
    exit 1
    clb jmk ljm lnh rms rxr
}

list(){
    list_voices=
    for filename in ${voices_dir}*
    do
        name=$(sed -E 's/.*(\w{3})\..*/\1/' <<< "$filename")
        list_voices="${list_voices}${name} "
    done
    echo "$list_voices"
    exit 1
}

while :; do
    case $1 in
        -l|--list)
            list
            ;;
        -d|--demo)
            if [[ "$2" ]]; then
                demo $2
                shift
            else
                demo
            fi
            ;;
        -v|--voice)
            if [[ "$2" ]]; then
                voice=$2
                shift
            else
                die 'ERROR: "-v|--voice" requires a non-empty option argument'
            fi
            ;;
        -s|--speed)
            if [[ "$2" ]]; then
                speed=$2
                shift
            else
                die 'ERROR: "-s|--speed" requires a non-empty option argument'
            fi
            ;;
        -f|--file)
            if [[ "$2" ]]; then
                file=$2
                shift
            else
                die 'ERROR: "-f|--file" requires a non-empty option argument'
            fi
            ;;
        -h|--help|-\?)
            HELP
            exit
            ;;
        --) # End of all options
            shift
            break
            ;;
        -?*)
            echo "Error: Unknown option: $1" >&2
            exit 1
            ;;
        *)  # No more options
            break
            ;;
    esac
    shift
done

set_voice_path(){
    voice_path="${1}cmu_us_${2}.flitevox"
}

set_voice(){
    if [[ "$voice" ]]; then
        set_voice_path "$voices_dir" "$voice"
    else
        # default voice
        set_voice_path "$voices_dir" "$default_voice"
    fi
}

set_speed(){
    if [[ -z ${speed} ]]; then
        speed=$default_speed
    fi
}

set_voice
set_speed

# Debug message
# echo "voice:${voice} file:${file} speed:${speed} text:${*}"
# if file or text
if [[ "$file" ]]; then
    flite --setf duration_stretch=$speed -voice "$voice_path" -f "$file"
    echo "if file"
else
    flite --setf duration_stretch=$speed -voice "$voice_path" -t "$*"
fi
