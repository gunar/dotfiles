#!/usr/bin/env sh

curl https://raw.githubusercontent.com/publicsuffix/list/master/public_suffix_list.dat \
  | sed /^$/d \
  | grep -v "^//" \
  | grep -v "\\." \
  >tlds.dat
