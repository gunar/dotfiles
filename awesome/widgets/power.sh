seconds=${1:-1}

while true; do
  pstate-frequency --get|grep performance >/dev/null
  powersave=$?
  upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep state|grep discharging >/dev/null
  charging=$?
  percentage=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0|grep percentage | grep -Eo '[0-9]{1,3}')
  echo "${powersave},${charging},${percentage}"
  sleep "$seconds"
done
