#!/usr/bin/sh

if [ $# -eq 0 ]
then
  echo "Usage: ./download.sh <filename>"
  exit 0
fi
aws s3 cp "s3://${AWS_S3_BUCKET}/$1" - \
  | gpg --decrypt >"$1" || exit 1
