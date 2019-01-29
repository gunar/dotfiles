# Gunar's dotfiles

This README is empty but the files are quite organized.

If everything goes according to plan, running `install.sh` should install everything! But it probably won't as I keep changing settings without reinstalling the OS to make sure everything is working. So yeah, use at your own risk.

## How to set up wifi 

Placeholder as I usually need this when after reinstalling the OS.

```
$ iw dev
$ ip link set wlan0 up
$ iw wlan0 scan
$ wpa_passphrase <network name> >> /etc/wpa_supplicant.conf
$ wpa_supplicant -i wlan0 -c /etc/wpa_supplicant.conf
$ iw wlan0 link
$ dhclient wlan0
$ ping 8.8.8.8
(Where wlan0 is wifi adapter and <network name> is SSID)
(Add Routing manually)
$ ip route add default via 10.0.0.138 dev wlan0
```
