#!/usr/bin/env sh
torify curl --silent --location --http1.0 --compressed --fail \
   --cookie cookies.txt \
   --cookie-jar cookies.txt \
   -H "Accept: text/html, text/plain, text/sgml, text/css, application/xhtml+xml, */*;q=0.01" \
   -H "Accept-Encoding: gzip, compress, bzip2" \
   -H "Accept-Language: en" \
   --user-agent "Lynx/2.8.9dev.16 libwww-FM/2.14 SSL-MM/1.4.1 GNUTLS/3.5.17" \
   --url "http://3g2upl4pq6kufc4m.onion/lite/?q=$1"
   # --url "https://duckduckgo.com/lite/?q=$1"

