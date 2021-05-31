#!/bin/bash
DROPBOX_DIR=/home/elodin/Sync
REMOTE=dropbox

find $DROPBOX_DIR | entr -rd rclone sync -v --delete-during $DROPBOX_DIR $REMOTE:
