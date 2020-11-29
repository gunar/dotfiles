#!/bin/bash
 
# This shell script shows the network speed, both received and transmitted.
 
# Usage: net_speed.sh interface
#   e.g: net_speed.sh eth0
 
 
# Global variables
interface=$1
seconds=$2
received_bytes=""
old_received_bytes=""
transmitted_bytes=""
old_transmitted_bytes=""
 
 
# This function parses /proc/net/dev file searching for a line containing $interface data.
# Within that line, the first and ninth numbers after ':' are respectively the received and transmited bytes.
get_bytes()
{
    line=$(cat /proc/net/dev | grep $interface | cut -d ':' -f 2 | awk '{print "received_bytes="$1, "transmitted_bytes="$9}')
    eval $line
}
 
 
# Function which calculates the speed using actual and old byte number.
# Speed is shown in KByte per second when greater or equal than 1 KByte per second.
# This function should be called each second.
get_velocity()
{
    value=$1    
    old_value=$2
    printf "%.1f\n" "$(bc -l <<< "($value-$old_value)*8/1000/1000/$seconds")"
}
 
# Gets initial values.
get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
 
# Waits for one second.
sleep $seconds;
 
# Get new transmitted and received byte number values.
get_bytes

# Calculates speeds.
vel_recv=$(get_velocity $received_bytes $old_received_bytes)
vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes)

# Shows results in the console.
echo -n "$vel_recv,$vel_trans"
