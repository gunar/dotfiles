#!/bin/bash
xrandr -d :0 --output eDP1 --mode 1920x1080
xbacklight -set 1
amixer set Master 0

# Tell my SimpleScreenRecorder coordinator to stop recording
echo "record-save" | socat -t 1 - tcp:localhost:8124

i3lock --image=/home/gcg/dotfiles/awesome/themes/up.png --nofork

xbacklight -set 100

# Tell my SimpleScreenRecorder coordinator to resume recording
echo "record-start" | socat -t 1 - tcp:localhost:8124

# Pause encoding/uploading job
killall ffmpeg -s SIGSTOP
killall aws -s SIGSTOP
