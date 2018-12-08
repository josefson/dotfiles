#!/bin/bash

say=
clipboard=
vim=

help(){
    msg='./script.sh [output]
./script.sh [-s|-c|-v]
-s  will speak the content
-c  will copy to clipboard
-v  will open a vim buffer with the content'

    echo "${msg}"
}

while getopts 'scvh' FLAG; do
    case $FLAG in
        s)
            say=1
            ;;
        c)
            clipboard=1
            ;;
        v)
            vim=1
            ;;
        h)
            help
            exit
            ;;
    esac
done

tmp_img=/tmp/ocr_image.png
maim -s -k $tmp_img
convert $tmp_img -resize 300% -set colorspace Gray -separate -average -sigmoidal-contrast 10x60% $tmp_img
ocr_text=$(tesseract $tmp_img stdout 2>/dev/null)

# debugging
# echo "say: $say; clip: $clipboard; vim: $vim"
# echo "$ocr_text"

if [[ "$say" ]]; then
    $HOME/bin/say.sh "$ocr_text"
fi
if [[ "$clipboard" ]]; then
    echo "$ocr_text" | xclip -selection clipboard
fi
if [[ "$vim" ]]; then
    echo "$ocr_text" | xclip -selection clipboard
    vim -g <(xsel --clipboard --output)
fi

exit 1
