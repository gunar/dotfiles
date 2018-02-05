#!/bin/bash

VALUE=$(cat)

# Color codes
red=`echo -e '\033[0;31m'`
yellow=`echo -e '\033[0;33m'`
blue=`echo -e '\033[0;34m'`
NC=`echo -e '\033[0m' # No colors`

echo "$VALUE" | \
  sed "s/feat:/${blue}feat:/ " | \
  sed "s/fix:/${red}fix:/" | \
  sed "s/refactor:/${yellow}refactor:/" | \
  sed "s/refact:/${yellow}refact:/" | \
  sed "s/chore:/chore:/" | \
  sed 's/docs:/docs:/' | \
  sed 's/style:/style:/' | \
  sed 's/test:/test:/' | \
  sed 's/Merge/Merge/'

