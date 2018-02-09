# Gunar's dotfiles

TODO:
- how to automate downloading commercial fonts I've bought?



## How to set up wifi 

root@kali:~# iw dev
root@kali:~# ip link set wlan0 up
root@kali:~# iw wlan0 scan
root@kali:~# wpa_passphrase <network name> >> /etc/wpa_supplicant.conf
root@kali:~# wpa_supplicant -i wlan0 -c /etc/wpa_supplicant.conf
root@kali:~# iw wlan0 link
root@kali:~# dhclient wlan0
root@kali:~# ping 8.8.8.8
(Where wlan0 is wifi adapter and <network name> is SSID)
(Add Routing manually)
root@kali:~# ip route add default via 10.0.0.138 dev wlan0
