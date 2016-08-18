#!/usr/bin/env bash
SOURCE=/home/gcg
DESTINATION=/run/media/gcg/backup/home

# Export list of installed packages
pacman -Qqe | grep -v "$(pacman -Qmq)" > $SOURCE/.pkglist

# Backup HOME directory to SD card
if [ ! -d "$DESTINATION" ]; then
  echo "ERROR: $DESTINATION does not exist. Is the SD card mounted? Exiting now."
  exit
fi
# `cd` so we're in the same directory as "exclude_files.txt"
cd `dirname $0`
rsync -aAXv --omit-dir-times --delete --exclude-from='exclude_files.txt' $SOURCE/ $DESTINATION
