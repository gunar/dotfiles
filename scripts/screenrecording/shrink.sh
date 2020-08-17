#!/usr/bin/env sh
cd /home/gcg/screenrecordings/in-progress || exit 1
for f in ./*.mkv; do
  ffmpeg -i "$f" -r 10 -c:a libvorbis -c:v libx264 -preset faster -crf 28 -max_interleave_delta 0 "../shrinked/$f" && mv "$f" ../raw/
done
