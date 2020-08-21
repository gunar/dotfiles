#!/usr/bin/env sh

# Try to resume a paused encoding job
pgrep ffmpeg | xargs kill -s SIGCONT

# Ensure single process — https://stackoverflow.com/a/7305448/1456173
exec 200<"$0"
flock -n 200 || exit 1

cd /home/gcg/screenrecordings/in-progress || exit 1
for f in ./*.mkv; do
  ffmpeg -y -i "$f" -r 10 -c:a libvorbis -c:v libx264 -preset faster -crf 28 -max_interleave_delta 0 "../shrinked/$f" && mv "$f" ../raw/
done
