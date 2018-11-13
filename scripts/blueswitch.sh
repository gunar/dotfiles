#!/bin/bash
# edswitch
# CLI options:  `a2dp': Audio Profile
#               `hsp':  Telephony Profile
#               <Index> Default Sink (try `0' or `1')
SINK=$( pacmd list-cards | grep -B 1 bluez )
INDEX=${SINK:10:2}
SINK=$( pacmd list-cards | grep bluez )
MAC=${SINK:19:17}
BT_SINK="bluez_sink.$MAC"
BT_SOURCE="bluez_source.$MAC"

CURRENT=$( pacmd list-cards | grep -oP "(a2dp_sink|headset_head_unit)" | head -n 3 | tail -n 1 )

if echo $CURRENT|grep headset_head_unit; then
  pacmd set-card-profile $INDEX a2dp_sink
  # pacmd set-default-sink $BT_SINK
elif echo $CURRENT|grep a2dp_sink; then
  pacmd set-card-profile $INDEX headset_head_unit
  # pacmd set-default-sink $BT_SINK
  # pacmd set-default-source $BT_SOURCE
else
  echo Error! Resetting to internal audio
  pacmd set-default-sink $1
  pacmd set-default-source $1
fi
