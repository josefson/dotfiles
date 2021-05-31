#!/bin/bash

disk=/dev/disk/by-label/DATA

case $1 in
    'on')
        echo "mounting $disk"
        sudo udevil mount -o noatime $disk
        ;;
    'off')
        echo "umounting $disk"
        sync
        sudo udevil umount $disk
        echo "putting disk to sleep"
        sudo hdparm -Y $disk
        ;;
    -h|--help)
        echo "[on|off] only options"
        ;;
    *)
        echo "[on|off] only options"
        ;;
esac
