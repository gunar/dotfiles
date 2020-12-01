#!/usr/bin/env bash
 
# This shell script prints the network speed, both received and transmitted, every $seconds
# 
# Usage: net_speed.sh interface
#   e.g: net_speed.sh eth0
#
 
# Global variables
interface=$1
seconds=$2
 
get_bytes() {
  line=$(grep "$interface" </proc/net/dev | cut -d ':' -f 2 | awk '{print $1,$9}')
  # received,transmitted
  echo "$line"
}
 
get_speed() {
  # Function which calculates the speed using actual and old byte number.
  # Speed is shown in KByte per second when greater or equal than 1 KByte per second.
  value=$1    
  old_value=$2
  printf "%.1f\n" "$(bc -l <<< "($value-$old_value)*8/1000/1000/$seconds")"
}
 
# Initialize accumulator
IFS=" " read -r old_down old_up <<<"$(get_bytes)"

while true; do
  sleep "$seconds";
  IFS=" " read -r down up <<<"$(get_bytes)"
  echo "$(get_speed "$down" "$old_down"),$(get_speed "$up" "$old_up")"
  old_down=$down
  old_up=$up
done

