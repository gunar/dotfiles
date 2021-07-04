#!/usr/bin/env sh

set -xe

# TODO: Trigger this script in the middle of the night

# Try to resume a paused encoding/upload job
killall ffmpeg -s SIGCONT || true
killall aws -s SIGCONT || true

# Ensure single process — https://stackoverflow.com/a/7305448/1456173
exec 200<"$0"
flock -n 200 || (echo "There's an instance of this script running already" ; exit 1)

# Merge -------------------------------------------------------------------------
cd /home/gcg/screenrecordings/in-progress || exit 1
mkdir -p ../by-day
# XXX: Ignore last day to prevent multiple files per day               vvvvvvvvvv
PREFIXES=$(find . -name '*.mkv' | sort | uniq | cut -d'_' -f 1 | uniq | head -n -1)
for prefix in ${PREFIXES}; do
  rm -f files.txt
  echo "Processing prefix ${prefix}"
  for file in $(find . -wholename "${prefix}*" | sort); do
    echo "file '$file'" >>files.txt
  done
  # If merging videos with and without the side screen isn't working, could try this tool https://mkvtoolnix.download/doc/mkvmerge.html
  ffmpeg -f concat -safe 0 -i files.txt -c copy "../by-day/${prefix}.mkv" || exit 1
  for file in $(find . -wholename "${prefix}*" | sort); do
    rm "$file"
  done
done

# Upload -------------------------------------------------------------------------
cd "/home/gcg/dotfiles/scripts/screenrecording" || exit 1
eval "$(direnv export bash)" 
cd /home/gcg/screenrecordings/by-day || exit 1
# Keep last 7 days of recording locally --------vvvvvvvvvv
for filepath in $(find . -name '*.mkv' | sort | head -n -7); do
  filename=$(basename "${filepath}")
  echo "Encrypting and uploading file '${filename}'"
  gpg --encrypt -r gunar@gunargessner.com <"${filepath}" \
    | trickle -u 500 aws s3 cp - "s3://${AWS_S3_BUCKET}/${filename}" --storage-class DEEP_ARCHIVE  \
    || exit 1
  echo "Done! Removing '${filename}'"
  rm "$filepath" || exit 1
done
