#!/bin/bash
# edswitch
# CLI options:  `a2dp': Audio Profile
#               `hsp':  Telephony Profile
#               <Index> Default Sink (try `0' or `1')
set +v
SINK=$( pacmd list-cards | grep -B 1 bluez )
INDEX=${SINK:10:2}
SINK=$( pacmd list-cards | grep bluez )
MAC=${SINK:19:17}
BT_SINK="bluez_sink.$MAC"
BT_SOURCE="bluez_source.$MAC"

CURRENT=$( pacmd list-cards | grep -oP "(a2dp_sink|headset_head_unit)" | head -n 3 | tail -n 1 )

function move_all {
  sink=$1

  sleep 1 # pulseaudio is quite slow sometimes...

  pacmd list-source-outputs | grep index | while read line
  do
    index=$(echo $line | cut -f2 -d' ')
    # Ignore errors because some sources are "DONT_MOVE" (what I think means, not being used)
    #                                     vvvvvvvvvvvvvvv
    pacmd move-source-output $index $sink 2>&1 >/dev/null
  done
}

if echo $CURRENT|grep headset_head_unit; then
  echo "Setting to High Quality mode"
  pacmd set-card-profile $INDEX a2dp_sink
  pacmd set-default-sink $BT_SINK

  move_all alsa_input.pci-0000_00_1f.3.analog-stereo

elif echo $CURRENT|grep a2dp_sink; then
  echo "Setting to Phone mode"
  pacmd set-card-profile $INDEX headset_head_unit
  # pacmd set-default-sink $BT_SINK
  # pacmd set-default-source $BT_SOURCE.headset_head_unit

  move_all bluez_source.04_FE_A1_E8_D9_20.headset_head_unit

else
  echo Error! Resetting to internal audio
  pacmd set-default-sink $1
  pacmd set-default-source $1
fi
